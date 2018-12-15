//
//  BaseViewController.swift
//  AdminApp
//
//  Created by Ahmed on 12/12/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit

/**
 Base View Controller For All Controllers of the app.
 ````
 lazy var errorView = ConnectionErrorView()
 ````
 
 - activityIndicator: Outlet connected to an activity indicator when loading.
 
 ## Important Notes ##
 This controller is the base view controller For The APP.
 */

class BaseViewController: UIViewController {
        
    lazy var errorView = ConnectionErrorView()
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.constructConnectionErrorView()
        getData()
    }
    
    func getData() {
        self.errorView.isHidden = true
        self.beginLoadingAnimation()
    }
    
    func beginLoadingAnimation() {
        self.activityIndicator?.startAnimating()
    }
    
    func endLoadingAnimation()  {
        
    }
    
    func constructConnectionErrorView() {
        if !self.view.subviews.contains(errorView){
            errorView.frame = self.view.frame
            self.view.addSubview(errorView)
            errorView.isHidden = true
            self.errorView.tryAgainBtn.addTarget(self, action: #selector(viewDidLoad), for: .touchUpInside)
        }
    }

}
