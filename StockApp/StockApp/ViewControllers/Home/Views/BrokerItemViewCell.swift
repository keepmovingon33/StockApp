//
//  BrokerItemViewCell.swift
//  StockApp
//
//  Created by Sky on 3/8/21.
//

import UIKit

class BrokerItemViewCell: UICollectionViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var joiningTimeLabel: UILabel!
    @IBOutlet weak var inboxButton: UIButton!
    @IBOutlet weak var interestRateValueLabel: UILabel!
    @IBOutlet weak var interestRateLabel: UILabel!
    @IBOutlet weak var interestRateLineView: UIView!
    @IBOutlet weak var winRateValueLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var winRateLineView: UIView!
    @IBOutlet weak var totalStockValueLabel: UILabel!
    @IBOutlet weak var totalStockLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var interestView: UIView!
    @IBOutlet weak var winRateView: UIView!
    @IBOutlet weak var totalStockView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 16) / 1.3).isActive = true
        interestRateLabel.attributedText = NSAttributedString(string: "Lai Thang", attributes: TextFormatting.smallGrayRegular)
        winRateLabel.attributedText = NSAttributedString(string: "Ty Le Thang", attributes: TextFormatting.smallGrayRegular)
        totalStockLabel.attributedText = NSAttributedString(string: "Tong So Ma", attributes: TextFormatting.smallGrayRegular)
        inboxButton.setImage(UIImage(named: "inbox"), for: .normal)
        interestRateLineView.backgroundColor = UIColor.purpleColor
        winRateLineView.backgroundColor = UIColor.purpleColor
        avatarImage.setBorderRadius(with: 25)
        setupShadow()
        resetUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetUI()
    }
    
    private func resetUI() {
        avatarImage.image = nil
        nameLabel.attributedText = nil
        joiningTimeLabel.attributedText = nil
        interestRateValueLabel.attributedText = nil
        winRateValueLabel.attributedText = nil
        totalStockValueLabel.attributedText = nil
        interestView.isHidden = true
        winRateView.isHidden = true
        totalStockView.isHidden = true
    }
    
    func configure(user: User) {
        avatarImage.setImageWith(urlString: user.avatar, placeholder: UIImage(named: "memberAvatar"))
        nameLabel.attributedText = NSAttributedString(string: user.name, attributes: TextFormatting.blackRegularTitle)
        let joiningTime = user.createdAt.toString(with: "dd/MM/yy")
        joiningTimeLabel.attributedText = NSAttributedString(string: "Tham gia từ \(joiningTime)", attributes: TextFormatting.smallGrayRegular)
        if let profit = user.profit {
            interestRateValueLabel.attributedText = NSAttributedString(string: "\(profit)%", attributes: TextFormatting.bigGraySemibold)
            interestView.isHidden = false
        }
        
        if let winRate = user.winRate {
            winRateValueLabel.attributedText = NSAttributedString(string: "\(winRate)%", attributes: TextFormatting.bigGraySemibold)
            winRateView.isHidden = false
        }
        
        if let totalStock = user.totalStockFinish {
            totalStockValueLabel.attributedText = NSAttributedString(string: String(totalStock), attributes: TextFormatting.bigGraySemibold)
            totalStockView.isHidden = false
        }
    }
    
    private func setupShadow() {
        // day la lop thu hai, dung de set border
        contentView.setBorderRadius(with: 8)
        // self la lop dau tien, dung de set shadow va background color cua no phai clear
        self.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 4)
        self.backgroundColor = .clear
    }
}
