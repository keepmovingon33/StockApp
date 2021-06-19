//
//  CreateStockViewController.swift
//  StockApp
//
//  Created by Sky on 5/20/21.
//

import UIKit

class CreateStockViewController: BaseViewController {
    
    @IBOutlet weak var createStockView: UIView!
    @IBOutlet weak var stockCodeLabel: UILabel!
    @IBOutlet weak var stockCodeTextField: UITextField!
    @IBOutlet weak var stockCodeSeparator: UIView!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceLabelTextField: UITextField!
    @IBOutlet weak var priceSeparatorView: UIView!
    @IBOutlet weak var holdingTimeView: UIView!
    @IBOutlet weak var holdingTimeLabel: UILabel!
    @IBOutlet weak var holdingTimeValueLabel: UILabel!
    @IBOutlet weak var holdingTimeImage: UIImageView!
    @IBOutlet weak var holdingTimeSeparatorView: UIView!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteSeparatorView: UIView!
    
    
    
    @IBOutlet weak var publishLabel: UILabel!
    @IBOutlet weak var publishTableView: UITableView!
    @IBOutlet weak var finishButton: UIButton!
    
    
    @IBOutlet weak var createRoomAvatar: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    
    @IBOutlet weak var borderView: UIView!
    
    var rooms: [String] = [Constants.CreateStock.publishValue1, Constants.CreateStock.publishValue2, Constants.CreateStock.publishValue3]
    var selectRoomAt: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupTableView()
        setupStyling()
        title = Constants.CreateRoom.title
        setupBackButton()
    }
    
    private func configure() {
        stockCodeLabel.attributedText = NSAttributedString(string: Constants.CreateStock.stockCode, attributes: TextFormatting.blackMediumTitle)
        stockCodeTextField.placeholder = Constants.CreateStock.stockCodePlaceholder
        stockCodeTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        stockCodeTextField.textColor = UIColor.grayColor
        stockCodeTextField.borderStyle = .none
        stockCodeSeparator.backgroundColor = UIColor.grayColor
        
        priceLabel.attributedText = NSAttributedString(string: Constants.CreateStock.price, attributes: TextFormatting.blackMediumTitle)
        priceLabelTextField.placeholder = Constants.CreateStock.pricePlaceholder
        priceLabelTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        priceLabelTextField.textColor = UIColor.grayColor
        priceLabelTextField.borderStyle = .none
        priceSeparatorView.backgroundColor = UIColor.grayColor

        holdingTimeLabel.attributedText = NSAttributedString(string: Constants.CreateStock.holdingTime, attributes: TextFormatting.blackMediumTitle)
        holdingTimeValueLabel.attributedText = NSAttributedString(string: Constants.CreateStock.holdingTimeValue, attributes: TextFormatting.purpleValue)
        holdingTimeImage.image = UIImage(named: "dropdown")
        holdingTimeSeparatorView.backgroundColor = UIColor.grayColor
        
        noteLabel.attributedText = NSAttributedString(string: Constants.CreateStock.note, attributes: TextFormatting.blackMediumTitle)
        noteTextView.attributedText = NSAttributedString(string: Constants.CreateStock.notePlaceholder, attributes: TextFormatting.grayValue)
        noteSeparatorView.backgroundColor = UIColor.grayColor
        
        publishLabel.attributedText = NSAttributedString(string: Constants.CreateStock.publish, attributes: TextFormatting.blackMediumTitle)
        finishButton.setAttributedTitle(NSAttributedString(string: Constants.CreateStock.finishButton, attributes: TextFormatting.whiteText), for: .normal)
        finishButton.setGradientBackground()
        
        createRoomAvatar.image = UIImage(named: "createStock")
        avatarView.backgroundColor = .clear
    }
    
    private func setupTableView() {
        publishTableView.delegate = self
        publishTableView.dataSource = self
        publishTableView.separatorStyle = .none
    }
    
    private func setupStyling() {
        createStockView.setBorderRadius(with: 8)
        createStockView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        createStockView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        
        finishButton.setBorderRadius(with: 8)
        createRoomAvatar.setBorderRadius(with: 8)
        borderView.dropShadow(color: UIColor.shadowColor, opacity: 1, offSet: .zero, radius: 4)
        
    }

}

extension CreateStockViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PublishTableViewCell.identifier) as! PublishTableViewCell
        cell.configure(isSelected: selectRoomAt == indexPath.row, name: rooms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRoomAt = indexPath.row
        tableView.reloadData()
    }
}
