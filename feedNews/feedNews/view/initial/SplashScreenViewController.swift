//
//  SplashScreenViewController.swift
//  feedNews
//
//  Created by Millfford Bradshaw on 16/01/19.
//  Copyright © 2019 Millfford Bradshaw. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.goToMain()

        // Do any additional setup after loading the view.
    }
    
    func goToMain(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyBoard.instantiateInitialViewController() {
                UIApplication.shared.keyWindow?.rootViewController = viewController
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
