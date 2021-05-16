//
//  JoiningRoomItemViewCell.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import Kingfisher
import UIKit

class HorizontalRoomItemViewCell: UICollectionViewCell {
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
    
    @IBOutlet weak var winRateAndStockStackView: UIStackView!
    @IBOutlet weak var winRateView: UIView!
    @IBOutlet weak var totalStockView: UIView!
    @IBOutlet weak var createdAndMemberStackView: UIStackView!
    @IBOutlet weak var createdView: UIView!
    @IBOutlet weak var memberView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // we allow to change the constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        // we set width for each cell item. We minus 16 for the leading, and divide 2.7 (one screen has 2.7 items). because now we know the width of the cell item, now we could calculate the height for the cell item
        contentView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 16) / 2.7).isActive = true
        
        winRateImage.image = UIImage(named: "winRate")
        memberImage.image = UIImage(named: "member")
        clockImage.image = UIImage(named: "clock")
        avatarImage.setBorderRadius(with: 4)
        avatarImage.contentMode = .scaleAspectFill
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func resetUI() {
        ownerImage.image = nil
        avatarImage.image = nil
        nameLabel.attributedText = nil
        winRateLabel.attributedText = nil
        totalStockLabel.attributedText = nil
        createdTimeLabel.attributedText = nil
        memberLabel.attributedText = nil
        winRateView.isHidden = true
        totalStockView.isHidden = true
        winRateAndStockStackView.isHidden = false
        winRateDotView.isHidden = true
        createdView.isHidden = true
        createdDotView.isHidden = true
        createdAndMemberStackView.isHidden = false
        memberView.isHidden = true
        lockImage.image = UIImage(named: "lock")
    }
    
    func configure(room: Room) {
        if room.isRoomOwner() {
            ownerImage.image = UIImage(named: "owner")
        } else if room.isRoomAdmin() {
            ownerImage.image = UIImage(named: "admin")
        }
        
        avatarImage.setImageWith(urlString: room.avatar, placeholder: UIImage(named: "avatar"))
        
        if room.type == .publication {
            lockImage.image = nil
        }
        
        nameLabel.attributedText = NSAttributedString(string: room.name ?? "", attributes: TextFormatting.blackMediumTitle)
        if let winrate = room.winRate {
            winRateLabel.attributedText = NSAttributedString(string: "\(winrate)%", attributes: TextFormatting.smallGrayRegular)
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
            createdTimeLabel.attributedText = NSAttributedString(string: "\(months) thang", attributes: TextFormatting.smallGrayRegular)
            createdView.isHidden = false
            
        }
        if let member = room.member {
            memberLabel.attributedText = NSAttributedString(string: "\(member)", attributes: TextFormatting.smallGrayRegular)
            memberView.isHidden = false
        }
        if room.createdAt != nil && room.member != nil {
            createdDotView.isHidden = false
        } else if room.createdAt == nil && room.member == nil {
            createdAndMemberStackView.isHidden = true
        }
    }
}
