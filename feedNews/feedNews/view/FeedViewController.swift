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
    private var feedPresenter: FeedPresenter!
    private var feedNews = FeedViewData()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedPresenter = FeedPresenter(feedPresenterDelegate: self)
        self.build()
    }

}

//MARK: AUXILIARY METHODS
extension FeedViewController {
    
    func build(){
        feedPresenter.getFeedNews()
    }
    
}

//MARK: TABLEVIEW DELEGATES
extension FeedViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedNews.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  feedNewsTableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsTableViewCell
        cell.prepareCell(feedNews.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "details") as! DetailsViewController
        //detailsViewController.
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }

}

// MARK: PRESENTER DELEGATE

extension FeedViewController: FeedPresenterDelegate {
    func showFeedNews(_ feedNews: FeedViewData) {
        self.feedNews = feedNews
        feedNewsTableView.reloadData()
    }

}






