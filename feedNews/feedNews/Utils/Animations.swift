//
//  Animations.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 16/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class AnimationEffects {
    
    private var view: UIView?
    
    init(){}
        
    init(_ view: UIView){
        self.view = view
    }
    
    func showViewLoading(jsonName: String){
        //showOverlayBackground(view: self.view!)
        createLoadingInView(view: self.view!, jsonName: jsonName)
    }
    
    func showImageLoading(imageView: UIImageView, jsonName: String){
        createLoadingInImageView(imageView: imageView, jsonName: jsonName)
    }
    
    func removeViewLoading() {
        if let loadingView = self.view!.viewWithTag(200){
            loadingView.removeFromSuperview()
            removeOverlayBackground(view: self.view!)
        }
    }
    
    func removeImageViewLoading(imageView: UIImageView){
        if let loadingImageView = imageView.viewWithTag(600){
            loadingImageView.removeFromSuperview()
        }
    }
    
    func showError(jsonName: String, _ errorDescription: String){
        showOverlayBackground(view: self.view!)
        createErrorView(view: self.view!, errorDescription, jsonName: jsonName)
    }
    
    @objc func removeErrorView(_ sender: UITapGestureRecognizer){
        if let errorView = self.view!.viewWithTag(300), let closeIcon = self.view!.viewWithTag(400), let descriptionError = self.view!.viewWithTag(500){
            errorView.removeFromSuperview()
            closeIcon.removeFromSuperview()
            descriptionError.removeFromSuperview()
            removeOverlayBackground(view: self.view!)
        }
    }
    
    
    func showOverlayBackground(view: UIView){
        let overlayView = UIView()
        overlayView.frame = CGRect(x:0, y:0, width: view.frame.width, height: view.frame.height)
        overlayView.backgroundColor = UIColor(white: 2.0, alpha: 0.8)
        overlayView.tag = 100
        view.addSubview(overlayView)
    }
    
    func removeOverlayBackground(view: UIView){
        if let overlayView =  self.view!.viewWithTag(100){
            overlayView.removeFromSuperview()
        }
    }
    
    func createLoadingInView(view: UIView, jsonName: String){
        let loadingView: LOTAnimationView = LOTAnimationView(name:jsonName)
        loadingView.contentMode = .scaleToFill
        loadingView.frame = CGRect(x:0, y:0, width:200, height:150)
        loadingView.center = view.center
        loadingView.tag = 200
        loadingView.loopAnimation = true
        loadingView.play()
        view.addSubview(loadingView)
    }
    
    func createLoadingInImageView(imageView: UIImageView, jsonName: String){
        let loadingImageView: LOTAnimationView = LOTAnimationView(name:jsonName)
        loadingImageView.contentMode = .scaleAspectFit
        loadingImageView.frame = CGRect(x:0, y:0, width:60, height:60)
        loadingImageView.center = imageView.center
        loadingImageView.tag = 600
        loadingImageView.loopAnimation = true
        loadingImageView.play()
        imageView.addSubview(loadingImageView)
    }
    
    func createErrorView(view: UIView, _ errorDescription: String, jsonName: String){
        let errorView: LOTAnimationView = LOTAnimationView(name:jsonName)
        errorView.contentMode = .scaleToFill
        errorView.frame = CGRect(x:160, y:300, width:100, height:100)
        errorView.tag = 300
        errorView.play()
        createCloseIcon(view: view)
        createDescriptionErrorLabel(view: view, errorDescription)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.removeErrorView(_:)))
        view.addGestureRecognizer(gesture)
        view.addSubview(errorView)
    }
    
    func createCloseIcon(view: UIView){
        let imageName = "close-o"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.frame = CGRect(x:190, y:550, width:35, height:35)
        imageView.tag = 400
        view.addSubview(imageView)
    }
    
    func createDescriptionErrorLabel(view: UIView, _ errorDescription: String){
        let labelDescription: UILabel = UILabel()
        labelDescription.frame = CGRect(x:35, y:450, width:350, height:65)
        labelDescription.font = UIFont.boldSystemFont(ofSize: 17)
        labelDescription.textColor = .orange
        labelDescription.textAlignment = .center
        labelDescription.numberOfLines = 3
        labelDescription.text = errorDescription
        labelDescription.tag = 500
        view.addSubview(labelDescription)
    }
    
    func animateButton(_ sender: UIButton){
        UIButton.animate(withDuration: 0.2, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.975, y: 0.96)
        },
                         completion: { finish in
                            UIButton.animate(withDuration: 0.2, animations: {
                                sender.transform = CGAffineTransform.identity
                            })
        })
    }
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, self.scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

