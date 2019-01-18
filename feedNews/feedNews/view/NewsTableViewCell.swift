//
//  NewsTableViewCell.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 15/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

//MARK: PROTOCOL
protocol NewsTableViewCellDelegate: NSObjectProtocol {
    func reloadData()
}

class NewsTableViewCell: UITableViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var vwSeparator: UIView!
    @IBOutlet weak var vwContentView: UIView!
    @IBOutlet weak var lbErrorMessage: UILabel!
    @IBOutlet weak var ivReloadImage: UIImageView!
    @IBOutlet weak var vwAnimation: LOTAnimationView!
    
    //MARK: ATTRIBUTES
    private var animations = AnimationEffects()
    var newsTableViewCellDelegate: NewsTableViewCellDelegate!
    var errorTextForCell: String!
    
    //MARK: OVERRIDE METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: AUXILIARY METHODS
extension NewsTableViewCell{
    
    @objc func reloadData(){
        UIView.animate(withDuration: 0.2, animations: {
            self.ivReloadImage.transform = self.ivReloadImage.transform.rotated(by: CGFloat(Double.pi * 2))
        }) { (animationComplete) in
            self.newsTableViewCellDelegate?.reloadData()
        }
    }
    
    func prepareSuccessCell(_ article: ArticlesViewData, isLastRow: Bool) {
        
        lbTitle.text = article.title
        lbDescription.text = article.description
        setImage(url: article.urlToImage)
        if isLastRow{
            vwSeparator.isHidden = true
        }
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
    
    func prepareErrorCell(){
        startAnimation()
        self.lbErrorMessage.text = errorTextForCell
        UIView.animate(withDuration: 0.3) {
            self.ivReloadImage.transform = self.ivReloadImage.transform.rotated(by: CGFloat(Double.pi))
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.reloadData))
        self.vwContentView.addGestureRecognizer(gesture)
    }
    
    func startAnimation(){
        vwAnimation.setAnimation(named: "wow")
        vwAnimation.loopAnimation = true
        vwAnimation.play()
    }
}
