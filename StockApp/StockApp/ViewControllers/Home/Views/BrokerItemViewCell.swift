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
        mainView.setBorderRadius(with: 8)
//        setupShadow()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nameLabel.attributedText = nil
        joiningTimeLabel.attributedText = nil
        interestRateValueLabel.attributedText = nil
        interestRateLabel.attributedText = nil
        winRateValueLabel.attributedText = nil
        winRateLabel.attributedText = nil
        totalStockValueLabel.attributedText = nil
        totalStockLabel.attributedText = nil
        inboxButton.setImage(nil, for: .normal)
    }
    
    func configure() {
        avatarImage.image = UIImage(named: "memberAvatar")
        nameLabel.attributedText = NSAttributedString(string: "Giang Nguyen", attributes: TextFormatting.blackRegularTitle)
        joiningTimeLabel.attributedText = NSAttributedString(string: "Tham gia tu 01/02/18", attributes: TextFormatting.smallGreyRegular)
        interestRateValueLabel.attributedText = NSAttributedString(string: "20%", attributes: TextFormatting.bigGreySemibold)
        interestRateLabel.attributedText = NSAttributedString(string: "Lai Thang", attributes: TextFormatting.smallGreyRegular)
        winRateValueLabel.attributedText = NSAttributedString(string: "87%", attributes: TextFormatting.bigGreySemibold)
        winRateLabel.attributedText = NSAttributedString(string: "Ty Le Thang", attributes: TextFormatting.smallGreyRegular)
        totalStockValueLabel.attributedText = NSAttributedString(string: "6", attributes: TextFormatting.bigGreySemibold)
        totalStockLabel.attributedText = NSAttributedString(string: "Tong So Ma", attributes: TextFormatting.smallGreyRegular)
        inboxButton.setImage(UIImage(named: "inbox"), for: .normal)
        interestRateLineView.backgroundColor = .red
        
    }
    
    private func setupShadow() {
//        mainView.backgroundColor =  .orange
        contentView.setBorderRadius(with: 8)
        mainView.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 1, offSet: CGSize(width: 0.5, height: 0.5), radius: 8, scale: true)
        
        topView.backgroundColor = .clear
        stackView.backgroundColor = .clear
        winRateView.backgroundColor = .clear
        interestView.backgroundColor = .clear
        totalStockView.backgroundColor = .clear
    }

}
