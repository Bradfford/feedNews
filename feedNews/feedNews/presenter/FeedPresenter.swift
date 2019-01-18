//
//  FeedPresenter.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 15/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import Foundation

//MARK: STRUCT VIEW DATA
struct FeedViewData {
    var status: String = ""
    var totalResults: Int64 = 0
    var articles = [ArticlesViewData]()
}

struct ArticlesViewData {
    var source = SourceViewData()
    var author: String = ""
    var title: String = ""
    var description: String = ""
    var url: String = ""
    var urlToImage: String = ""
    var publishedAt: String = ""
    var content: String = ""
}

struct SourceViewData {
    var id: String = ""
    var name: String = ""
}

//MARK: PRESENTER DELEGATE
protocol FeedPresenterDelegate: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func showEmptyListAlert(message: String)
    func showRequestError(message: String)
    func showConnectionError(message: String)
    func showFeedNews(_ viewData: FeedViewData)
}

//MARK: PRESENTER CLASS
class FeedPresenter {
    
    private var feedViewData: FeedViewData!
    private let feedInteractor = FeedInteractor()
    private var feedNewsDelegate: FeedPresenterDelegate!
    
    init(feedPresenterDelegate: FeedPresenterDelegate){
        self.feedNewsDelegate = feedPresenterDelegate
    }
}

enum Messages: String {
    case connection_error = "Ops!\n Verifique sua conexão\n e recarregue a página."
    case request_error = "Ops!\n Algo de errado aconteceu.\n Recarregue a página."
    case emptylist_error = "Ops!\n Parece que não há informações \n a serem exibidas."
}

//MARK: CALL SERVICE
extension FeedPresenter {
    
    func getFeedNews(){
        
        if !Reachability.isConnectedToNetwork(){
            self.feedNewsDelegate?.showConnectionError(message: Messages.connection_error.rawValue)
            return
        }
        
        self.feedNewsDelegate?.startLoading()
            self.feedInteractor.getFeedNews(successCompletion: { (feedNews) in
                if let viewData = self.parseToViewData(model: feedNews){
                    self.feedNewsDelegate?.finishLoading()
                    self.feedNewsDelegate?.showFeedNews(viewData)
                } else {
                    self.feedNewsDelegate?.finishLoading()
                    self.feedNewsDelegate?.showEmptyListAlert(message: Messages.emptylist_error.rawValue)
                }
            }, errorCompletion: { (error) in
                self.feedNewsDelegate?.finishLoading()
                self.feedNewsDelegate?.showRequestError(message: Messages.request_error.rawValue)
            })
        
    }
}

//MARK: AUXILIARY METHODS
extension FeedPresenter {
    
    func parseToViewData(model: FeedNews?) -> FeedViewData? {
        if let feedNewsModel = model, let articlesModel = feedNewsModel.articles, !articlesModel.isEmpty {
            self.feedViewData = FeedViewData()
            self.feedViewData.status = feedNewsModel.status ?? ""
            self.feedViewData.totalResults = feedNewsModel.totalResults ?? 0
            //self.feedViewData.articles = [ArticlesViewData]()
            
            for article in articlesModel {
                var articleViewData = ArticlesViewData()
                articleViewData.author = article.author ?? "Autor desconhecido"
                articleViewData.title = article.title ?? ""
                articleViewData.description = article.description ?? ""
                articleViewData.url = article.url ?? ""
                articleViewData.urlToImage = article.urlToImage ?? ""
                articleViewData.publishedAt = article.publishedAt ?? ""
                articleViewData.content = article.content ?? ""
                articleViewData.source = SourceViewData()
                articleViewData.source.id = article.source?.id ?? ""
                articleViewData.source.name = article.source?.name ?? ""
                
                self.feedViewData.articles.append(articleViewData)
            }
            return nil
        }
        return nil
    }
}
