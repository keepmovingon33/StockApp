//
//  RoomDetailsViewController.swift
//  StockApp
//
//  Created by Sky on 3/3/21.
//

import UIKit

class RoomDetailsViewController: UIViewController {

    
    @IBOutlet weak var roomDetailsBottomView: UIView!
    @IBOutlet weak var roomActionUIView: UIView!
    @IBOutlet weak var stackViewBottom: UIStackView!
    
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
    
    
    @IBOutlet weak var roomModeUserView: UIView!
    @IBOutlet weak var roomModeLabel: UILabel!
    @IBOutlet weak var roomModeValueLabel: UILabel!
    
    @IBOutlet weak var roomModeOwnerView: UIView!
    @IBOutlet weak var roomModeOwnerLabel: UILabel!
    
    @IBOutlet weak var publicImage: UIImageView!
    @IBOutlet weak var publicLabel: UILabel!
    @IBOutlet weak var privateImage: UIImageView!
    @IBOutlet weak var privateLabel: UILabel!
    @IBOutlet weak var secretImage: UIImageView!
    @IBOutlet weak var secretLabel: UILabel!
    @IBOutlet weak var modeDescriptionLabel: UILabel!
    
    
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var displaySettingLabel: UILabel!
    @IBOutlet weak var displaySettingImage: UIImageView!
    
    @IBOutlet weak var messageSearchLabel: UILabel!
    @IBOutlet weak var messageSearchImage: UIImageView!
    
    
    @IBOutlet weak var memberListLabel: UILabel!
    @IBOutlet weak var memberListImage: UIImageView!
    
    @IBOutlet weak var memberBlockView: UIView!
    @IBOutlet weak var MemberblockLabel: UILabel!
    @IBOutlet weak var memberBlockImage: UIImageView!
    
    @IBOutlet weak var suggestionNotiView: UIView!
    @IBOutlet weak var suggestionNotiLabel: UILabel!
    @IBOutlet weak var suggestionNotiSwitchButton: UISwitch!
    
    @IBOutlet weak var messageNotiLabel: UILabel!
    @IBOutlet weak var messageNotiSwitchButton: UISwitch!
    
    @IBOutlet weak var reportAndLeaveView: UIStackView!
    
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var reportImage: UIImageView!
    
    
    @IBOutlet weak var leaveLabel: UILabel!
    @IBOutlet weak var leaveImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupShadow()
    }
    
    private func configureUI() {
        nameLabel.attributedText = NSAttributedString(string: "Phòng Tư Vấn Chứng Khoán Ngành Ngân Hàng", attributes: TextFormatting.blackHeader)
        editButton.setAttributedTitle(NSAttributedString(string: Constants.RoomDetails.editButton, attributes: TextFormatting.purpleButtonText), for: .normal)
        createdLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.createdTime, attributes: TextFormatting.blackRegularTitle)
        createdValueLabel.attributedText = NSAttributedString(string: "2 tháng trước", attributes: TextFormatting.grayValue)
        winRateLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.winRate, attributes: TextFormatting.blackRegularTitle)
        winRateValueLabel.attributedText = NSAttributedString(string: "87%", attributes: TextFormatting.grayValue)
        totalStockLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.totalStock, attributes: TextFormatting.blackRegularTitle)
        totalStockValueLabel.attributedText = NSAttributedString(string: "5", attributes: TextFormatting.purpleValue)
        totalMemberLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.totalMember, attributes: TextFormatting.blackRegularTitle)
        totalMemberValueLabel.attributedText = NSAttributedString(string: "23", attributes: TextFormatting.grayValue)
        estimationTimeLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.estimatedTime, attributes: TextFormatting.blackRegularTitle)
        estimationTimeValueLabel.attributedText = NSAttributedString(string: "Dưới 1 tháng", attributes: TextFormatting.grayValue)
        actualTimeLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.actualTime, attributes: TextFormatting.blackRegularTitle)
        actualTimeValueLabel.attributedText = NSAttributedString(string: "Dưới 1 tháng", attributes: TextFormatting.grayValue)
        DescriptionLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.description, attributes: TextFormatting.blackRegularTitle)
        descriptionValueLabel.attributedText = NSAttributedString(string: "Phòng của Broker Nguyễn Tấn Tài, phí tư vấn 1 tháng là 50k/tháng.", attributes: TextFormatting.grayValue)
        
        descriptionView.backgroundColor = UIColor.init(hexString: "#F3F6FF")
        
        arrowImage.image = UIImage(named: "icon_arrow")
        avatarImage.image = UIImage(named: "avatar")
        ownerImage.image = UIImage(named: "owner_admin")
        lockImage.image = UIImage(named: "lock")
        messageSearchImage.image = UIImage(named: "search")
        memberListImage.image = UIImage(named: "icon_arrow")
        displaySettingImage.image = UIImage(named: "icon_arrow")
        memberBlockImage.image = UIImage(named: "icon_arrow")
        reportImage.image = UIImage(named: "icon_arrow")
        leaveImage.image = UIImage(named: "icon_arrow")
        messageNotiSwitchButton.onTintColor = UIColor.init(hexString: "#9676F9")
        suggestionNotiSwitchButton.onTintColor = UIColor.init(hexString: "#9676F9")
        
        publicImage.image = UIImage(named: "selected")
        privateImage.image = UIImage(named: "unselected")
        secretImage.image = UIImage(named: "unselected")
        
        roomModeLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.roomMode, attributes: TextFormatting.blackRegularTitle)
        roomModeValueLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.publicMode, attributes: TextFormatting.purpleValue)
        roomModeOwnerLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.roomMode, attributes: TextFormatting.blackRegularTitle)
        modeDescriptionLabel.attributedText = NSAttributedString(string: "Ai cũng có thể thấy phòng trên danh sách các phòng và có thể tham gia phòng không cần xét duyệt.", attributes: TextFormatting.grayValue)
        displaySettingLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.displaySetting, attributes: TextFormatting.blackRegularTitle)
        publicLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.publicMode, attributes: TextFormatting.purpleValue)
        privateLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.privateMode, attributes: TextFormatting.purpleValue)
        secretLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.secretMode, attributes: TextFormatting.purpleValue)
        messageSearchLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.messageSearch, attributes: TextFormatting.blackRegularTitle)
        memberListLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.memberList, attributes: TextFormatting.blackRegularTitle)
        MemberblockLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.memberBlock, attributes: TextFormatting.blackRegularTitle)
        suggestionNotiLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.suggestionNoti, attributes: TextFormatting.blackRegularTitle)
        messageNotiLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.messageNoti, attributes: TextFormatting.blackRegularTitle)
        reportLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.report, attributes: TextFormatting.blackRegularTitle)
        leaveLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.leave, attributes: TextFormatting.redText)
    }
    
    private func setupShadow() {
        editButton.setBorderRadius(with: 4, color: UIColor.purpleColor, width: 0.5)
        
        roomDetailsBottomView.backgroundColor =  .white
        roomDetailsBottomView.setBorderRadius(with: 8)
        roomDetailsBottomView.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 1, offSet: CGSize(width: 0.5, height: 0.5), radius: 4)
        
        stackViewBottom.backgroundColor = UIColor.init(hexString: "#F5F2FF")
        stackViewBottom.setBorderRadius(with: 8)
        roomActionUIView.backgroundColor = .clear
        roomActionUIView.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 1, offSet: CGSize(width: 0, height: 0), radius: 4)
    }
}
