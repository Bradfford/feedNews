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
    
    func showError(jsonName: String){
        createErrorView(view: self.view!, jsonName: jsonName)
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
    
    func createErrorView(view: UIView, jsonName: String){
        let alertView: LOTAnimationView = LOTAnimationView(name:jsonName)
        alertView.contentMode = .scaleToFill
        alertView.frame = CGRect(x:160, y:300, width:100, height:100)
        alertView.tag = 300
        alertView.play()
        view.addSubview(alertView)
    }
    
}

