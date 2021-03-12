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
    
    var tapHandler: SimpleCompletion?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImage.image = UIImage(named: "icon_arrow")
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        contentView.addGestureRecognizer(tap)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        tapHandler?()
    }
    
    func configure(title: String) {
        titleLabel.attributedText = NSAttributedString(string: title, attributes: TextFormatting.purpleTitle)
    }
}
