//
//  BrokersViewController.swift
//  StockApp
//
//  Created by Sky on 3/10/21.
//

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
    let roomIdentifier = "RoomItemViewCell"
    var isBroker: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupNavbar()
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

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isBroker {
            let cell = tableView.dequeueReusableCell(withIdentifier: brokerIdentifier, for: indexPath) as! BrokerViewCell
            cell.configure()
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: roomIdentifier, for: indexPath) as! RoomItemViewCell
//            cell.configure(room: <#T##Room#>)
            cell.selectionStyle = .none
            return cell
        }
    }
}
