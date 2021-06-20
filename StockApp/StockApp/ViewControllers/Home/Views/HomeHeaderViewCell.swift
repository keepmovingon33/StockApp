//
//  HomeHeaderViewCell.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import UIKit

class HomeHeaderViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImage.image = UIImage(named: "icon_arrow")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
    }
    
    func configure(title: String) {
        titleLabel.attributedText = NSAttributedString(string: title, attributes: TextFormatting.purpleTitle)
    }
}
