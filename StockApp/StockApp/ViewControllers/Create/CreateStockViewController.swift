//
//  CreateStockViewController.swift
//  StockApp
//
//  Created by Sky on 5/20/21.
//

import Alamofire
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
    @IBOutlet weak var holdingTimeValueLabel: UILabel!
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
    
    var selectRoomAt: Int = 0
    var pickerView = UIPickerView()
    var rooms: [Room] = []
    var roomIds: [String] = []
    
    static func create(rooms: [Room]) -> CreateStockViewController {
        guard let vc = UIStoryboard.create.instantiateViewController(withIdentifier: "CreateStockViewController") as? CreateStockViewController else {
            fatalError("Cannot create CreateStockViewController")
        }
        
        vc.rooms = rooms
        return vc
    }
    
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
        priceLabelTextField.keyboardType = .decimalPad
        priceLabelTextField.borderStyle = .none
        priceSeparatorView.backgroundColor = UIColor.grayColor

        holdingTimeLabel.attributedText = NSAttributedString(string: Constants.CreateStock.holdingTime, attributes: TextFormatting.blackMediumTitle)
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
        // tintColor cho 1 textField chinh la dau nhay khi minh click vao textfield do. Khi minh set clear, minh ko thay dau nhay nua
        // tintColor cho navbar se la mau cua nut back button
        holdingTimeTextField.tintColor = .clear
        
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

        // adding Done/Cancel button
        holdingTimeTextField.inputAccessoryView = toolBar
        holdingTimeValueLabel.attributedText = NSAttributedString(string: String(format: Constants.CreateStock.holdingTimePicker, String(1)), attributes: TextFormatting.purpleValue)
        donePicker()
    }
    
    @objc func donePicker() {
        let value = String(format: Constants.CreateStock.holdingTimePicker, String(pickerView.selectedRow(inComponent: 0) + 1))
        holdingTimeValueLabel.attributedText = NSAttributedString(string: value, attributes: TextFormatting.purpleValue)
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }
    
    private func callCreateSignalAPI() {
        guard let stockCode = stockCodeTextField.text, !stockCode.isEmpty else {
            Helpers.showAlert(message: "Please input stock code")
            return
        }
        guard let price = priceLabelTextField.text, !price.isEmpty else {
            Helpers.showAlert(message: "Please input price")
            return
        }
        
        guard let priceValue = Double(price), priceValue > 0 else {
            Helpers.showAlert(message: "Price value should be larger than zero")
            return
        }
        
        let endpoint: String = "https://admin.bstock.vn/api/v3/signals"
        let parameters = [
            "stock_code": stockCode,
            "room_ids": roomIds,
            "note": noteTextView.text ?? "",
            "price": priceValue,
            "holding_time": (pickerView.selectedRow(inComponent: 0) + 1) * 30
        ] as [String : Any]
        let headers = HTTPHeaders(["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzFhY2dieTZvdSIsInJvbGUiOjIsInN1YiI6IjMxYWNnYnk2b3UiLCJpc3MiOiJodHRwczovL2FkbWluLmJzdG9jay52bi9hcGkvc29jaWFsLWxvZ2luIiwiaWF0IjoxNjIxMTIwOTk2LCJleHAiOjE2MjYzMDQ5OTYsIm5iZiI6MTYyMTEyMDk5NiwianRpIjoidG5NSVJzNmw0M0lTMDRpMyJ9.fdvleFdSNY_nkWvEAs8vWTzj9-JCAgMDCPVxROVooi4"])
        showLoadingIndicator()
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    self.hideLoadingIndicator()
                    guard let data = response.data else { return }
            
            // this snippet code to debug if there is any mapping error
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let baseResponse = try decoder.decode(BaseResponse.self, from: data)
                if baseResponse.code == 1 {
                    self.navigationController?.popToRootViewController(animated: true)
                    Helpers.showAlert(message: "Create signal successfully")
                } else {
                    Helpers.showAlert(message: baseResponse.message)
                }
                
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
    
    @IBAction func finishButtonTapped(_ sender: Any) {
        callCreateSignalAPI()
    }
}

extension CreateStockViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PublishTableViewCell.identifier) as! PublishTableViewCell
        cell.configure(isSelected: roomIds.contains(rooms[indexPath.row].id), name: rooms[indexPath.row].name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = rooms[indexPath.row].id
        if let index = roomIds.firstIndex(of: id) {
            roomIds.remove(at: index)
        } else {
            roomIds.append(id)
        }
        tableView.reloadData()
    }
}

extension CreateStockViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 24
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: Constants.CreateStock.holdingTimePicker, String(row + 1))
    }
}
