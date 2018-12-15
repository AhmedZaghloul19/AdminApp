//
//  HeaderFilterView.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/8/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit

class HeaderFilterView: UIView {

    @IBOutlet weak var contentView:UIView!
    @IBOutlet var filterButtons:[FilterButton]!
    var selectedIndex = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Bundle.main.loadNibNamed("HeaderFilterView", owner: self, options: [:])
        addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
    }

    override func draw(_ rect: CGRect) {
       filterButtons.first?.isActived = true
    }
    
    @IBAction func filterButtonTapped(btn: FilterButton) {
        filterButtons[selectedIndex].isActived = !filterButtons[selectedIndex].isActived
        selectedIndex = btn.tag
        btn.isActived = true
    }
}
