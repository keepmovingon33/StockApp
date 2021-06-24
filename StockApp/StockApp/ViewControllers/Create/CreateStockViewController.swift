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
    @IBOutlet weak var holdingTimeTextField: UITextField!
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
    var pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupTableView()
        setupStyling()
        title = Constants.CreateStock.title
        setupBackButton()
        setupPickerView()
    }
    
    private func configure() {
        stockCodeLabel.attributedText = NSAttributedString(string: Constants.CreateStock.stockCode, attributes: TextFormatting.blackMediumTitle)
        stockCodeTextField.placeholder = Constants.CreateStock.stockCodePlaceholder
        stockCodeTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        stockCodeTextField.textColor = UIColor.blackColor
        stockCodeTextField.borderStyle = .none
        stockCodeSeparator.backgroundColor = UIColor.grayColor
        
        priceLabel.attributedText = NSAttributedString(string: Constants.CreateStock.price, attributes: TextFormatting.blackMediumTitle)
        priceLabelTextField.placeholder = Constants.CreateStock.pricePlaceholder
        priceLabelTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        priceLabelTextField.textColor = UIColor.blackColor
        priceLabelTextField.borderStyle = .none
        priceSeparatorView.backgroundColor = UIColor.grayColor

        holdingTimeLabel.attributedText = NSAttributedString(string: Constants.CreateStock.holdingTime, attributes: TextFormatting.blackMediumTitle)
        holdingTimeTextField.font = UIFont.systemFont(ofSize: 14)
        holdingTimeTextField.textColor = UIColor.purpleColor
        holdingTimeImage.image = UIImage(named: "dropdown")
        holdingTimeSeparatorView.backgroundColor = UIColor.grayColor
        
        noteLabel.attributedText = NSAttributedString(string: Constants.CreateStock.note, attributes: TextFormatting.blackMediumTitle)
        noteTextView.font = UIFont.systemFont(ofSize: 14)
        noteTextView.placeholder = Constants.CreateStock.notePlaceholder
        noteTextView.textColor = UIColor.blackColor
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
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self

        holdingTimeTextField.inputView = pickerView
        holdingTimeTextField.borderStyle = .none
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.purpleColor
        toolBar.sizeToFit()
  
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        holdingTimeTextField.inputAccessoryView = toolBar
        
        donePicker()
    }
    
    @objc func donePicker() {
        let value = HoldingType.allCases
        holdingTimeTextField.text = value[pickerView.selectedRow(inComponent: 0)].rawValue
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
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

extension CreateStockViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return HoldingType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return HoldingType.allCases[row].rawValue
    }
}
