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
    func showFeedNews(_ viewData: FeedViewData)
}

//MARK: PRESENTER CLASS
class FeedPresenter {
    
    private var feedViewData = FeedViewData()
    private let feedInteractor = FeedInteractor()
    private var feedNewsDelegate: FeedPresenterDelegate!
    
    init(feedPresenterDelegate: FeedPresenterDelegate){
        self.feedNewsDelegate = feedPresenterDelegate
    }
}

//MARK: CALL SERVICE
extension FeedPresenter {
    
    func getFeedNews(){
        self.feedInteractor.getFeedNews(successCompletion: { (feedNews) in
            if let viewData = self.parseToViewData(model: feedNews){
                self.feedNewsDelegate?.showFeedNews(viewData)
            } else {
                
            }
        }, errorCompletion: { (error) in
            
        })
    }
}

//MARK: AUXILIARY METHODS
extension FeedPresenter {
    
    func parseToViewData(model: FeedNews?) -> FeedViewData? {
        if let feedNewsModel = model, let articlesModel = feedNewsModel.articles, !articlesModel.isEmpty {
            self.feedViewData.status = feedNewsModel.status ?? ""
            self.feedViewData.totalResults = feedNewsModel.totalResults ?? 0
            
            for article in articlesModel {
                var articleViewData = ArticlesViewData()
                articleViewData.author = article.author ?? ""
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
            return self.feedViewData
        }
        return nil
    }
}
