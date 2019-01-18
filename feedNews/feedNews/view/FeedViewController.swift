//
//  ViewController.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 15/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    //MARK: OUTLETS
   @IBOutlet weak var feedNewsTableView: UITableView!
    
    //MARK: ATTRIBUTES
    private let refreshControl = UIRefreshControl()
    private var feedPresenter: FeedPresenter!
    private var animations: AnimationEffects!
    private var feedNews = FeedViewData()
    private var hasError = false
    private var errorMessage: String!
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedPresenter = FeedPresenter(feedPresenterDelegate: self)
        self.feedNewsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        self.animations = AnimationEffects(self.view)
        self.build()
    }

}

//MARK: TABLEVIEW DELEGATES
extension FeedViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getCountOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setupCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !hasError {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
            detailsViewController.viewData = feedNews.articles[indexPath.row]
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }

}

//MARK: AUXILIARY METHODS
extension FeedViewController {
    
    func build(){
        feedPresenter.getFeedNews()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        self.build()
        self.refreshControl.endRefreshing()
    }
    
    func setupCell(index: Int) -> NewsTableViewCell{
        if hasError {
            let cell =  feedNewsTableView.dequeueReusableCell(withIdentifier: "errorCell") as! NewsTableViewCell
            cell.errorTextForCell = errorMessage
            cell.prepareErrorCell()
            cell.newsTableViewCellDelegate = self
            return cell
        } else {
            let cell =  feedNewsTableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTableViewCell
            let isLastRow = feedNews.articles.count == index + 1 ? true : false
            cell.prepareSuccessCell(feedNews.articles[index], isLastRow: isLastRow)
            return cell
        }
    }
    
    func getCountOfRows() -> Int{
        return hasError ? 1 : feedNews.articles.count
    }
    
}

// MARK: DELEGATES
extension FeedViewController: FeedPresenterDelegate {
    
    func showEmptyListAlert(message: String) {
        self.errorMessage = validateMessage(message)
        self.hasError = true
        self.feedNewsTableView.reloadData()
    }
    
    func showRequestError(message: String) {
        self.errorMessage = validateMessage(message)
        self.hasError = true
        self.feedNewsTableView.reloadData()
    }
    
    func showConnectionError(message: String) {
        self.errorMessage = validateMessage(message)
        self.hasError = true
        self.feedNewsTableView.reloadData()
    }
    
    func validateMessage(_ message: String) -> String {
        if self.errorMessage != nil {
            self.errorMessage.removeAll()
            self.errorMessage = message
        } else {
            self.errorMessage = message
        }
        return self.errorMessage
    }
    
    
    func startLoading() {
        animations.showViewLoading(jsonName: "preloader")
    }
    
    func finishLoading() {
        animations.removeViewLoading()
    }
    
    func showFeedNews(_ feedNews: FeedViewData) {
        self.feedNews = feedNews
        self.hasError = false
        self.feedNewsTableView.reloadData()
    }

}

extension FeedViewController: NewsTableViewCellDelegate {
    func reloadData() {
        build()
    }
    
}






