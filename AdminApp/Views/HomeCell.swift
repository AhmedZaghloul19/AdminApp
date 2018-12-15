//
//  HomeCell.swift
//  AdminApp
//
//  Created by Ahmed Zaghloul on 12/8/18.
//  Copyright © 2018 Ahmed Zaghloul. All rights reserved.
//

import UIKit
import Kingfisher

class HomeCell: UITableViewCell {

    @IBOutlet weak var typeHolderView: UIView!
    @IBOutlet weak var cellImageView:UIImageView!
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var modelLabel:UILabel!
    @IBOutlet weak var ipAddressLabel:UILabel!
    @IBOutlet weak var subnetMaskLabel:UILabel!
    @IBOutlet weak var statusView:UIView!
    @IBOutlet weak var holderView:UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet var functionalityImageViews:[UIImageView]!
    
    var sshActiveColor = UIColor(red: 93/255, green: 69/255, blue: 214/255, alpha: 1)
    var telnetActiveColor = UIColor(red: 224/255, green: 86/255, blue: 193/255, alpha: 1)
    var scheduleActiveColor = UIColor(red: 54/255, green: 183/255, blue: 216/255, alpha: 1)
    var speakerActiveColor = UIColor(red: 239/255, green: 121/255, blue: 120/255, alpha: 1)
    var deactivatedColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)

    var content:Content! {
        didSet{
            self.titleLabel.text = content.name!
            let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/SVG_Green_electronic_board_without_components.svg/2000px-SVG_Green_electronic_board_without_components.svg.png")
            cellImageView.kf.setImage(with: url, placeholder: UIImage(named: "worldwide"), options: [.transition(ImageTransition.fade(1))], progressBlock: { receivedSize, totalSize in
            }, completionHandler: { image, error, cacheType, imageURL in
            })
            self.modelLabel.text = content.model?.name!
            self.ipAddressLabel.text = content.ipAddress!
            self.subnetMaskLabel.text = content.ipSubnetMask!
            self.typeLabel.text = content.type?.name!
            switch content.status ?? .green {
            case Status.green:
                self.statusView.backgroundColor = .green
            case Status.orange:
                self.statusView.backgroundColor = .orange
            case Status.yellow:
                self.statusView.backgroundColor = .yellow
            default:
                self.statusView.backgroundColor = .red
            }
            
            functionalityImageViews[0].backgroundColor = content.communicationProtocols.contains(where: {$0.type == .ssh}) ? sshActiveColor : deactivatedColor
            functionalityImageViews[1].backgroundColor = content.communicationProtocols.contains(where: {$0.type == .telnet}) ? telnetActiveColor : deactivatedColor
            functionalityImageViews[2].backgroundColor = content.communicationProtocols.contains(where: {$0.type == .other}) ? scheduleActiveColor : deactivatedColor
            functionalityImageViews[3].backgroundColor = content.communicationProtocols.contains(where: {$0.type == .speaker}) ? speakerActiveColor : deactivatedColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.holderView.dropShadow(scale: true, WithDirection: .bottom)
            self.typeHolderView.layer.borderColor = UIColor.lightGray.cgColor
            self.typeHolderView.layer.borderWidth = 1
            self.typeHolderView.layer.cornerRadius = self.typeHolderView.frame.height / 2
            self.cellImageView.layer.cornerRadius = self.cellImageView.frame.height / 2
            self.statusView.layer.cornerRadius = self.statusView.frame.height / 2
            for img in self.functionalityImageViews {
                img.layer.cornerRadius = img.frame.height / 2
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

}
