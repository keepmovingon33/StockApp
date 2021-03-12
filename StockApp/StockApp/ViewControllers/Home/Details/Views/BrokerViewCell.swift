//
//  BrokerViewCell.swift
//  StockApp
//
//  Created by Sky on 3/10/21.
//

import UIKit

class BrokerViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        interestRateLineView.backgroundColor = UIColor.purpleColor
        winRateLineView.backgroundColor = UIColor.purpleColor
        setupShadow()
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
        inboxButton.setAttributedTitle(nil, for: .normal)
    }
    
    func configure() {
        avatarImage.image = UIImage(named: "memberAvatar")
        nameLabel.attributedText = NSAttributedString(string: "Giang Nguyen", attributes: TextFormatting.blackRegularTitle)
        joiningTimeLabel.attributedText = NSAttributedString(string: "Tham gia tu 01/02/18", attributes: TextFormatting.smallGrayRegular)
        interestRateValueLabel.attributedText = NSAttributedString(string: "20%", attributes: TextFormatting.bigGraySemibold)
        interestRateLabel.attributedText = NSAttributedString(string: "Lai Theo Thang", attributes: TextFormatting.smallGrayRegular)
        winRateValueLabel.attributedText = NSAttributedString(string: "87%", attributes: TextFormatting.bigGraySemibold)
        winRateLabel.attributedText = NSAttributedString(string: "Ty Le Thang", attributes: TextFormatting.smallGrayRegular)
        totalStockValueLabel.attributedText = NSAttributedString(string: "6", attributes: TextFormatting.bigGraySemibold)
        totalStockLabel.attributedText = NSAttributedString(string: "Tong So Ma", attributes: TextFormatting.smallGrayRegular)
        inboxButton.setAttributedTitle(NSAttributedString(string: Constants.HomeDetails.inbox, attributes: TextFormatting.purpleButtonText), for: .normal)
    }
    
    func setupShadow() {
        self.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        self.backgroundColor = .clear
        
        mainView.setBorderRadius(with: 8)
        mainView.backgroundColor = .white
        inboxButton.setBorderRadius(with: 4, color: UIColor.purpleColor, width: 0.5)
    }
    
}
