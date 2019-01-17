//
//  ViewController.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 15/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

   @IBOutlet weak var feedNewsTableView: UITableView!
    private let refreshControl = UIRefreshControl()

    private var feedPresenter: FeedPresenter!
    private var animations: AnimationEffects!
    private var feedNews = FeedViewData()
    private var hasRequestError = false
    
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
        if !hasRequestError {
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
        if hasRequestError {
            let cell =  feedNewsTableView.dequeueReusableCell(withIdentifier: "errorCell") as! NewsTableViewCell
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
        return hasRequestError ? 1 : feedNews.articles.count
    }
    
}

// MARK: DELEGATES

extension FeedViewController: FeedPresenterDelegate {
    
    func startLoading() {
        animations.showViewLoading(jsonName: "preloader")
    }
    
    func finishLoading() {
        animations.removeViewLoading()
    }
    
    func showEmptyListAlert() {
    
    }
    
    func showRequestError() {
        self.hasRequestError = true
        self.feedNewsTableView.reloadData()
    }
    
    func showFeedNews(_ feedNews: FeedViewData) {
        self.feedNews = feedNews
        self.hasRequestError = false
        self.feedNewsTableView.reloadData()
    }

}

extension FeedViewController: NewsTableViewCellDelegate {
    func reloadData() {
        build()
    }
    
}






