//
//  NewsTableViewCell.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 15/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var vwSeparator: UIView!
    
    @IBOutlet weak var lbErrorMessage: UILabel!
    
    private var animations = AnimationEffects()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
            if let _ = image {
                self.animations.removeImageViewLoading(imageView: self.ivImage)
            }
        }
    }
    
    func prepareErrorCell(){
        self.lbErrorMessage.text = "Ops!\n Algo de errado aconteceu.\n Recarregue a página."
    }

}
