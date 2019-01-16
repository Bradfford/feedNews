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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(_ article: ArticlesViewData) {
        
        lbTitle.text = article.title
        lbDescription.text = article.description
        setImage(url: article.urlToImage)
    }
    
    func setImage(url: String){
        
        let urlImage = url
        let resource = ImageResource(downloadURL: URL(string: urlImage)!, cacheKey: urlImage)
        ivImage.kf.setImage(with: resource, options: nil) {
            (image, error, cacheType, urlImage) in
            if let downloadedImage = image {
                //TODO remover loading image
            }
        }
    }

}
