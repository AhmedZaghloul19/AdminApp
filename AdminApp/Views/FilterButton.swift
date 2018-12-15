//
//  FilterButton.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/8/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit

class FilterButton: UIButton {

    let selectedColor = UIColor(red: 35/255 , green: 165/255 , blue: 1 , alpha: 1)
    let defaultColor = UIColor.white
    
    var isActived:Bool = false {
        didSet{
            self.updateButton()
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.height / 2
            self.clipsToBounds = true
            self.updateButton()
        }
    }
 
    func updateButton() {
        self.backgroundColor = isActived ? selectedColor : defaultColor
        self.setTitleColor(isActived ? .white : UIColor.darkGray, for: .normal)
        self.titleEdgeInsets = UIEdgeInsets(top: 8,left: 8,bottom: 8,right: 8)
        self.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        self.layer.borderWidth = isActived ? 0 : 1.5
        self.tintColor = isActived ? .white : UIColor.darkGray
    }
    
}
