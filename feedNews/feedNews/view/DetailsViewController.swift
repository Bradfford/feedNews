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

    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lbUrl: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var viewData = ArticlesViewData()
    private var animations = AnimationEffects()

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        build()

        // Do any additional setup after loading the view.
    }
    
    func build(){
        self.lbDescription.text = viewData.title
        self.lbUrl.text = viewData.url
        self.lbContent.text = viewData.content
        setImage(url: viewData.urlToImage)
        let urlGesture = UITapGestureRecognizer(target: self, action: #selector(self.openUrl))
        self.lbUrl.isUserInteractionEnabled = true
        self.lbUrl.addGestureRecognizer(urlGesture)
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
            //UIApplication.shared.openURL(url as URL)
        }
    }
}
