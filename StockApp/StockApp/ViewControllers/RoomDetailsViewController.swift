//
//  RoomDetailsViewController.swift
//  StockApp
//
//  Created by Sky on 3/3/21.
//

import UIKit

class RoomDetailsViewController: UIViewController {

    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var createdValueLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var winRateValueLabel: UILabel!
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var totalStockValueLabel: UILabel!
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var totalMemberLabel: UILabel!
    @IBOutlet weak var totalMemberValueLabel: UILabel!
    @IBOutlet weak var estimationTimeLabel: UILabel!
    @IBOutlet weak var estimationTimeValueLabel: UILabel!
    @IBOutlet weak var actualTimeLabel: UILabel!
    @IBOutlet weak var actualTimeValueLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var descriptionValueLabel: UILabel!
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var lockImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    private func configureUI() {
        nameLabel.attributedText = NSAttributedString(string: "Phòng Tư Vấn Chứng Khoán Ngành Ngân Hàng", attributes: TextFormatting.blackHeader)
        editButton.setAttributedTitle(NSAttributedString(string: Constants.RoomDetails.editButton, attributes: TextFormatting.purpleButtonText), for: .normal)
        createdLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.createdTime, attributes: TextFormatting.blackTitle)
        createdValueLabel.attributedText = NSAttributedString(string: "2 tháng trước", attributes: TextFormatting.greyValue)
        winRateLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.winRate, attributes: TextFormatting.blackTitle)
        winRateValueLabel.attributedText = NSAttributedString(string: "87%", attributes: TextFormatting.greyValue)
        totalStockLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.totalStock, attributes: TextFormatting.blackTitle)
        totalStockValueLabel.attributedText = NSAttributedString(string: "5", attributes: TextFormatting.purpleValue)
        totalMemberLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.totalMember, attributes: TextFormatting.blackTitle)
        totalMemberValueLabel.attributedText = NSAttributedString(string: "23", attributes: TextFormatting.greyValue)
        estimationTimeLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.estimatedTime, attributes: TextFormatting.blackTitle)
        estimationTimeValueLabel.attributedText = NSAttributedString(string: "Dưới 1 tháng", attributes: TextFormatting.greyValue)
        actualTimeLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.actualTime, attributes: TextFormatting.blackTitle)
        actualTimeValueLabel.attributedText = NSAttributedString(string: "Dưới 1 tháng", attributes: TextFormatting.greyValue)
        DescriptionLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.description, attributes: TextFormatting.blackTitle)
        descriptionValueLabel.attributedText = NSAttributedString(string: "Phòng của Broker Nguyễn Tấn Tài, phí tư vấn 1 tháng là 50k/tháng.", attributes: TextFormatting.greyValue)
        
        arrowImage.image = UIImage(named: "icon_arrow")
        avatarImage.image = UIImage(named: "avatar")
        ownerImage.image = UIImage(named: "owner_admin")
        lockImage.image = UIImage(named: "lock")
        
    }
}
