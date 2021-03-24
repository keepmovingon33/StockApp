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
    
    let brokerIdentifier = "BrokerViewCell"
    let roomIdentifier = "VerticalRoomItemViewCell"
    var isBroker: Bool = true
    var brokers: [User] = []
    var page: Int = 1
    var total: Int = 0
    var refreshControl = UIRefreshControl()
    
    var endpoint: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupNavbar()
        fetchBrokerData()
        setupRefreshControl()
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
    
    // will setup this navbar for the first screen
    func setupNavbar() {
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        title = Constants.HomeDetails.brokerTitle
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = UIColor.purpleColor
        navigationController?.navigationBar.titleTextAttributes = TextFormatting.purpleHeader
        
        // lam mat duong line giua navbar voi view
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        page = 1
        brokers = []
        tableView.reloadData()
        fetchBrokerData()
    }
    
    private func fetchBrokerData() {
        guard let endpoint = endpoint else {
            fatalError("endpoint must not be nil")
        }
        
        let headers = HTTPHeaders(["Content-Type": "application/x-www-form-urlencoded",
                                  "Accept": "application/json",
                                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzFhY2dieTZvdSIsInJvbGUiOjIsInN1YiI6IjMxYWNnYnk2b3UiLCJpc3MiOiJodHRwczovL2FkbWluLmJzdG9jay52bi9hcGkvc29jaWFsLWxvZ2luIiwiaWF0IjoxNjE1NTY0OTUzLCJleHAiOjE2MjA3NDg5NTMsIm5iZiI6MTYxNTU2NDk1MywianRpIjoiR3dMYUhUOVpmZ0g3ZEVtZSJ9.gO3sYmCiTs8YnNhRV3Y0-X_bDx0RQs5VtTsVIEKzSQ4"])
        let parameters = ["page": page]
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
                let brokerResponse = try decoder.decode(BrokerResponse.self, from: data)
                self.total = brokerResponse.data.total
                self.brokers.append(contentsOf: brokerResponse.data.list)
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

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isBroker {
            return brokers.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBroker {
            let cell = tableView.dequeueReusableCell(withIdentifier: brokerIdentifier, for: indexPath) as! BrokerViewCell
            cell.configure(user: brokers[indexPath.row])
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: roomIdentifier, for: indexPath) as! VerticalRoomItemViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == brokers.count && brokers.count < total {
            page += 1
            fetchBrokerData()
        }
    }
}
