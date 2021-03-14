//
//  RoomItemViewCell.swift
//  StockApp
//
//  Created by Sky on 3/9/21.
//

import UIKit

class VerticalRoomItemViewCell: UITableViewCell {

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
    
    
    @IBOutlet weak var winRateAndStockStackView: UIStackView!
    @IBOutlet weak var winRateView: UIView!
    @IBOutlet weak var winRateDotView: UIView!
    @IBOutlet weak var totalStockView: UIView!
    @IBOutlet weak var createdAndMemberStackView: UIStackView!
    @IBOutlet weak var createdView: UIView!
    @IBOutlet weak var createdDotView: UIView!
    @IBOutlet weak var memberView: UIView!
    
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
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.setBorderRadius(with: 4)
        
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetUI()
    }
    
    private func resetUI() {
        avatarImage.image = nil
        ownerImage.image = nil
        
        roomLabel.attributedText = nil
        winRateValue.attributedText = nil
        totalStockLabel.attributedText = nil
        createdLabel.attributedText = nil
        memberValueLabel.attributedText = nil
        lockImage.image = UIImage(named: "lock")
        requestButton.isHidden = false
        winRateView.isHidden = true
        totalStockView.isHidden = true
        winRateAndStockStackView.isHidden = false
        winRateDotView.isHidden = true
        createdView.isHidden = true
        createdDotView.isHidden = true
        createdAndMemberStackView.isHidden = false
        memberView.isHidden = true
    }

    func configure(room: Room) {
        avatarImage.setImageWith(urlString: room.avatar, placeholder: UIImage(named: "avatar"))
        if room.isRoomOwner() {
            ownerImage.image = UIImage(named: "owner")
        } else if room.isRoomAdmin() {
            ownerImage.image = UIImage(named: "admin")
        }
        
        if room.type == .publication {
            lockImage.image = nil
        }
        
        roomLabel.attributedText = NSAttributedString(string: room.name, attributes: TextFormatting.blackMediumTitle)
        if let winrate = room.winRate {
            winRateValue.attributedText = NSAttributedString(string: "\(winrate)%", attributes: TextFormatting.smallGrayRegular)
            winRateView.isHidden = false
        }
        if let totalStock = room.totalStockFinish {
            totalStockLabel.attributedText = NSAttributedString(string: "\(totalStock) ma", attributes: TextFormatting.smallGrayRegular)
            totalStockView.isHidden = false
        }
        if room.winRate != nil && room.totalStockFinish != nil {
            winRateDotView.isHidden = false
        } else if room.winRate == nil && room.totalStockFinish == nil {
            winRateAndStockStackView.isHidden = true
        }
    
        if let created = room.createdAt {
            let months = Date().months(from: created)
            createdLabel.attributedText = NSAttributedString(string: "\(months) thang", attributes: TextFormatting.smallGrayRegular)
            createdView.isHidden = false
            
        }
        if let member = room.member {
            memberValueLabel.attributedText = NSAttributedString(string: "\(member)", attributes: TextFormatting.smallGrayRegular)
            memberView.isHidden = false
        }
        if room.createdAt != nil && room.member != nil {
            createdDotView.isHidden = false
        } else if room.createdAt == nil && room.member == nil {
            createdAndMemberStackView.isHidden = true
        }
        
        if room.isInRoom() {
            requestButton.isHidden = true
        }
    }
    
}
