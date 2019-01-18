//
//  DetailsViewController.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 16/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var lbPublishedDate: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbUrl: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbAuthor: UILabel!
    
    //MARK: ATTRIBUTES
    var viewData = ArticlesViewData()
    private var animations = AnimationEffects()
    
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

}

//MARK: AUXULIARY METHODS
extension DetailsViewController {
    
    func build(){
        self.lbPublishedDate.text = viewData.publishedAt
        self.lbDescription.text = viewData.title
        self.lbUrl.text = viewData.url
        self.lbContent.text = viewData.content
        self.lbAuthor.text = viewData.author
        setImage(url: viewData.urlToImage)
        let urlGesture = UITapGestureRecognizer(target: self, action: #selector(self.openUrl))
        self.lbUrl.isUserInteractionEnabled = true
        self.lbUrl.addGestureRecognizer(urlGesture)
        let urlImageGesture = UITapGestureRecognizer(target: self, action: #selector(self.openUrlImage))
        self.ivImage.isUserInteractionEnabled = true
        self.ivImage.addGestureRecognizer(urlImageGesture)
    }
    
    func setImage(url: String){
        let urlImage = url
        let resource = ImageResource(downloadURL: URL(string: urlImage)!, cacheKey: urlImage)
        self.animations.createLoadingInImageView(imageView: ivImage, jsonName: "spinner_")
        self.ivImage.kf.setImage(with: resource, options: nil) {
            (image, error, cacheType, urlImage) in
            self.animations.removeImageViewLoading(imageView: self.ivImage)
        }
    }
    
    @objc func openUrl(){
        if let url = URL(string: viewData.url){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func openUrlImage(){
        if let url = URL(string: viewData.urlToImage){
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
    }
}
