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
    
    @IBOutlet weak var interestView: UIView!
    @IBOutlet weak var winRateView: UIView!
    @IBOutlet weak var totalStockView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        interestRateLineView.backgroundColor = UIColor.purpleColor
        winRateLineView.backgroundColor = UIColor.purpleColor
        inboxButton.setAttributedTitle(NSAttributedString(string: Constants.HomeDetails.inbox, attributes: TextFormatting.purpleButtonText), for: .normal)
        interestRateLabel.attributedText = NSAttributedString(string: Constants.Broker.interest, attributes: TextFormatting.smallGrayRegular)
        winRateLabel.attributedText = NSAttributedString(string: Constants.Broker.winRate, attributes: TextFormatting.smallGrayRegular)
        totalStockLabel.attributedText = NSAttributedString(string: Constants.Broker.totalStocks, attributes: TextFormatting.smallGrayRegular)
        avatarImage.setBorderRadius(with: 25)
        setupShadow()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImage.image = nil
        nameLabel.attributedText = nil
        joiningTimeLabel.attributedText = nil
        interestRateValueLabel.attributedText = nil
        winRateValueLabel.attributedText = nil
        totalStockValueLabel.attributedText = nil
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
    
    func setupShadow() {
        self.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        self.backgroundColor = .clear
        
        mainView.setBorderRadius(with: 8)
        mainView.backgroundColor = .white
        inboxButton.setBorderRadius(with: 4, color: UIColor.purpleColor, width: 0.5)
    }
    
}
