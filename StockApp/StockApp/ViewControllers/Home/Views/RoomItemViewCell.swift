//
//  RoomItemViewCell.swift
//  StockApp
//
//  Created by Sky on 3/9/21.
//

import UIKit

class RoomItemViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var lockImage: UIImageView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var winRateImage: UIImageView!
    @IBOutlet weak var winRateValue: UILabel!
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberValueLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var separatorLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        clockImage.image = UIImage(named: "clock")
        winRateImage.image = UIImage(named: "winRate")
        memberImage.image = UIImage(named: "member")
        requestButton.setAttributedTitle(NSAttributedString(string: Constants.RoomDetails.requestButton, attributes: TextFormatting.purpleButtonText), for: .normal)
        separatorLineView.backgroundColor = UIColor.gray
        requestButton.setBorderRadius(with: 4, color: UIColor.purpleColor, width: 0.5)
        self.contentView.backgroundColor = .clear
        mainView.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        ownerImage.image = nil
        lockImage.image = nil
        
        roomLabel.attributedText = nil
        winRateValue.attributedText = nil
        totalStockLabel.attributedText = nil
        createdLabel.attributedText = nil
        memberValueLabel.attributedText = nil
    }

    func configure() {
        avatarImage.image = UIImage(named: "avatar")
        ownerImage.image = UIImage(named: "owner_user")
        lockImage.image = UIImage(named: "lock")
        
        roomLabel.attributedText = NSAttributedString(string: "Phong Vip Chung Khoan - Luot Song abcdxyz", attributes: TextFormatting.blackMediumTitle)
        winRateValue.attributedText = NSAttributedString(string: "87%", attributes: TextFormatting.smallGrayRegular)
        totalStockLabel.attributedText = NSAttributedString(string: "6 ma", attributes: TextFormatting.smallGrayRegular)
        createdLabel.attributedText = NSAttributedString(string: "1 thang", attributes: TextFormatting.smallGrayRegular)
        memberValueLabel.attributedText = NSAttributedString(string: "23", attributes: TextFormatting.smallGrayRegular)
    }
    
}
