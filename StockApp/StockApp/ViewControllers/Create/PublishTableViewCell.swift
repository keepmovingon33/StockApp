//
//  PublishTableViewCell.swift
//  StockApp
//
//  Created by Sky on 6/1/21.
//

import UIKit

class PublishTableViewCell: UITableViewCell {

    static let identifier = "PublishTableViewCell"
    
    @IBOutlet weak var selectImage: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    func configure(isSelected: Bool, name: String) {
        selectImage.image = isSelected ? UIImage(named: "icon_check") : UIImage(named: "unselected")
        roomNameLabel.attributedText = NSAttributedString(string: name, attributes: TextFormatting.purpleValue)
    }

}
