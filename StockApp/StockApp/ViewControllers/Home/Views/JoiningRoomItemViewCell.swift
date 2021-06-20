//
//  JoiningRoomItemViewCell.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import UIKit

class JoiningRoomItemViewCell: UICollectionViewCell {
    // note: We set height for this item, the last view will has bottom constraint >= a number (not equal). So usually, a collection/table view at the bottom should has bottom constraint >= a number

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var winRateImage: UIImageView!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var winRateDotView: UIView!
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var createdDotView: UIView!
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // we allow to change the constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        // we set width for each cell item. We minus 16 for the leading, and divide 2.7 (one screen has 2.7 items). because now we know the width of the cell item, now we could calculate the height for the cell item
        contentView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 16) / 2.7).isActive = true
        
        lockImage.image = UIImage(named: "lock")
        winRateImage.image = UIImage(named: "winRate")
        memberImage.image = UIImage(named: "member")
        clockImage.image = UIImage(named: "clock")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ownerImage.image = nil
        avatarImage.image = nil
        nameLabel.attributedText = nil
        winRateLabel.attributedText = nil
        totalStockLabel.attributedText = nil
        createdTimeLabel.attributedText = nil
        memberLabel.attributedText = nil
    }
    
    func configure(name: String) {
        ownerImage.image = UIImage(named: "owner_user")
        avatarImage.image = UIImage(named: "avatar")
        nameLabel.attributedText = NSAttributedString(string: name, attributes: TextFormatting.blackMediumTitle)
        winRateLabel.attributedText = NSAttributedString(string: "87%", attributes: TextFormatting.smallGrayRegular)
        totalStockLabel.attributedText = NSAttributedString(string: "6 ma", attributes: TextFormatting.smallGrayRegular)
        createdTimeLabel.attributedText = NSAttributedString(string: "24 thang", attributes: TextFormatting.smallGrayRegular)
        memberLabel.attributedText = NSAttributedString(string: "23", attributes: TextFormatting.smallGrayRegular)
    }
}
