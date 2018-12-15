//
//  SideExtensionVC.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/12/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit

class SideExtensionVC: UIViewController {

    @IBOutlet weak var guideBarHeightConstratint: NSLayoutConstraint!
    @IBOutlet weak var userImageView:UIImageView!
    
    var fullViewXPosition: CGFloat {
        return 0
    }
    var partialViewXPosition: CGFloat {
        return  -(UIScreen.main.bounds.width * 0.1875)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(SideExtensionVC.panGesture))
        view.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
        }
    }
    
    @IBAction func panGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        
        let x = self.view.frame.minX
        self.view.frame.origin.x = self.view.frame.origin.x < 0 || translation.x < 0 ?  x + translation.x : 0
        recognizer.setTranslation(CGPoint.zero, in: self.view)
        if recognizer.state == .ended {
            var duration =  velocity.x < 0 ? Double((x - fullViewXPosition) / -velocity.x) : Double((partialViewXPosition - x) / velocity.x )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                print(velocity.x)
                if  velocity.x >= 0  {
                    self.view.frame = CGRect(x: self.fullViewXPosition, y: 0, width: self.view.frame.width , height: self.view.frame.height)
                    self.view.subviews.first!.alpha = 1
                    self.guideBarHeightConstratint.constant = 100
                    (self.parent! as! HomeVC).tableView.isUserInteractionEnabled = false
                    (self.parent! as! HomeVC).topBarView.isUserInteractionEnabled = false
                } else {
                    self.view.frame = CGRect(x: self.partialViewXPosition, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                    self.view.subviews.first!.alpha = 0
                    self.guideBarHeightConstratint.constant = 0.0
                    (self.parent! as! HomeVC).tableView.isUserInteractionEnabled = true
                    (self.parent! as! HomeVC).topBarView.isUserInteractionEnabled = true
                }
                
            }, completion: { (_) in
                
            })
        }
    }
    
    func prepareBackgroundView(){
        let blurEffect = UIBlurEffect.init(style: .dark)
        let visualEffect = UIVisualEffectView.init(effect: blurEffect)
        let bluredView = UIVisualEffectView.init(effect: blurEffect)
        bluredView.contentView.addSubview(visualEffect)
        visualEffect.frame = UIScreen.main.bounds
        bluredView.frame = UIScreen.main.bounds
        bluredView.alpha = 0
        view.insertSubview(bluredView, at: 0)
    }
    
}
