//
//  HeaderCounterView.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/8/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit

class HeaderCounterView: UIView {

    @IBOutlet weak var contentView:UIView!
    @IBOutlet weak var buttonsHolderView:UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("HeaderCounterView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        buttonsHolderView.dropShadow()
    }
 
    
}

enum ShadowDirection {
    case right
    case left
    case bottom
    case up
}

extension UIView {
    func dropShadow(scale: Bool = true,WithDirection direction:ShadowDirection = .left) {
        DispatchQueue.main.async {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.3
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = 1.5
            let coordinates :CGPoint!
            switch direction {
            case .right :
                    coordinates = CGPoint(x: 3, y: 0)
            case .left :
                coordinates = CGPoint(x: -2, y: 0)
            case .up :
                coordinates = CGPoint(x: 0, y: -2)
            case .bottom :
                coordinates = CGPoint(x: 0, y:  2)
            }
            let bounds = CGRect(x: coordinates.x, y: coordinates.y, width: self.bounds.width, height: self.bounds.height)
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }

}
