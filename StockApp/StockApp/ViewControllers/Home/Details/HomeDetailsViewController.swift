//
//  BrokersViewController.swift
//  StockApp
//
//  Created by Sky on 3/10/21.
//

import Alamofire
import UIKit

class HomeDetailsViewController: BaseViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sortingLabel: UILabel!
    @IBOutlet weak var sortingTypeLabel: UILabel!
    @IBOutlet weak var sortingTypeImage: UIImageView!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterImage: UIImageView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 150
            tableView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellReuseIdentifier: brokerIdentifier)
            tableView.register(UINib(nibName: roomIdentifier, bundle: nil), forCellReuseIdentifier: roomIdentifier)
            tableView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
        }
    }
    @IBOutlet weak var sortingTextField: UITextField!
    @IBOutlet weak var filterTextField: UITextField!
    
    let brokerIdentifier = "BrokerViewCell"
    let roomIdentifier = "VerticalRoomItemViewCell"
    var isBroker: Bool = true
    var brokers: [User] = []
    var rooms: [Room] = []
    var page: Int = 1
    var total: Int = 0
    var refreshControl = UIRefreshControl()
    var sortingPickerView = UIPickerView()
    var filteringPickerView = UIPickerView()
    
    var searchTimer: Timer?
    
    var endpoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBackButton()
        fetchBrokerData()
        setupRefreshControl()
        setupPickerView()
        
        searchTextField.delegate = self
        Helpers.showAlert(message: "Hello")
    }
    
    
    func configure() {
        searchView.setBorderRadius(with: 8, color: UIColor.purpleColor, width: 0.5)
        searchImage.image = UIImage(named: "search")
        let placeHolder = isBroker ? Constants.HomeDetails.searchPlaceholder : "Tìm kiếm các phòng"
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeHolder
                                                                   , attributes: TextFormatting.lightPurpleValue)
        searchTextField.borderStyle = .none
        sortingLabel.attributedText = NSAttributedString(string: Constants.HomeDetails.sorting, attributes: TextFormatting.grayValue)
        sortingTypeLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.winRate, attributes: TextFormatting.purpleValue)
        sortingTypeImage.image = UIImage(named: "dropdown")
        filterLabel.attributedText = NSAttributedString(string: Constants.RoomDetails.winRate, attributes: TextFormatting.purpleValue)
        filterImage.image = UIImage(named: "dropdown")
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh() {
        page = 1
        brokers = []
        rooms = []
        tableView.reloadData()
        fetchBrokerData()
    }
    
    private func fetchBrokerData() {
        guard let endpoint = endpoint else {
            fatalError("endpoint must not be nil")
        }
        
        let headers = HTTPHeaders(["Content-Type": "application/x-www-form-urlencoded",
                                  "Accept": "application/json",
                                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzFhY2dieTZvdSIsInJvbGUiOjIsInN1YiI6IjMxYWNnYnk2b3UiLCJpc3MiOiJodHRwczovL2FkbWluLmJzdG9jay52bi9hcGkvc29jaWFsLWxvZ2luIiwiaWF0IjoxNjIxMTIwOTk2LCJleHAiOjE2MjYzMDQ5OTYsIm5iZiI6MTYyMTEyMDk5NiwianRpIjoidG5NSVJzNmw0M0lTMDRpMyJ9.fdvleFdSNY_nkWvEAs8vWTzj9-JCAgMDCPVxROVooi4"])
        let value = isBroker ? SortingType.brokerCase : SortingType.roomCase
        let parameters = [
            "page": page,
            "order_by": "\(value[sortingPickerView.selectedRow(inComponent: 0)])",
            "keyword": searchTextField.text ?? ""
        ] as [String : Any]
        showLoadingIndicator()
        AF.request(endpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.hideLoadingIndicator()
            self.refreshControl.endRefreshing()
            guard let data = response.data else { return }
            
            // this snippet code to debug if there is any mapping error
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                if self.isBroker {
                    let brokerResponse = try decoder.decode(BrokerResponse.self, from: data)
                    self.total = brokerResponse.data.total
                    self.brokers.append(contentsOf: brokerResponse.data.list)
                } else { // for call Room API response
                    let roomResponse = try decoder.decode(RoomResponse.self, from: data)
                    self.total = roomResponse.data.total
                    // append(contendsOf) la minh append nguyen 1 array vao. con append khong thi minh append 1 element thoi
                    self.rooms.append(contentsOf: roomResponse.data.list)
                }
                
                self.tableView.reloadData()
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
    
    private func setupPickerView() {
        sortingPickerView.delegate = self
        sortingPickerView.dataSource = self

        sortingTextField.inputView = sortingPickerView
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
  
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        sortingTextField.inputAccessoryView = toolBar
        
        donePicker()
    }
    
    @objc func donePicker() {
        let value = isBroker ? SortingType.brokerCase : SortingType.roomCase
        sortingTypeLabel.text = value[sortingPickerView.selectedRow(inComponent: 0)].rawValue
        self.view.endEditing(true)
        refresh()
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }
    
}

extension HomeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isBroker {
            return brokers.count
        } else {
            return rooms.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBroker {
            let cell = tableView.dequeueReusableCell(withIdentifier: brokerIdentifier, for: indexPath) as! BrokerViewCell
            cell.configure(user: brokers[indexPath.row])
            cell.selectionStyle = .none // khi minh click vao 1 cell, ko tao ui thay doi, neu ko thi background color = grey cho cell do
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: roomIdentifier, for: indexPath) as! VerticalRoomItemViewCell
            cell.configure(room: rooms[indexPath.row])
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = isBroker ? brokers.count : rooms.count
        if indexPath.row + 1 == count && count < total {
            page += 1
            fetchBrokerData()
        }
    }
}

extension HomeDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return isBroker ? SortingType.brokerCase.count : SortingType.roomCase.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return isBroker ? SortingType.brokerCase[row].rawValue : SortingType.roomCase[row].rawValue
    }
}

extension HomeDetailsViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if searchTimer != nil {
            searchTimer?.invalidate()
            searchTimer = nil
        }
        searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(searchForKeyword(_:)), userInfo: textField.text, repeats: false)
    }
    
    @objc func searchForKeyword(_ timer: Timer) {
            refresh()
    }
}
