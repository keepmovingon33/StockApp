//
//  HomeViewController.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import Alamofire
import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 100
            // for header
            tableView.sectionHeaderHeight = UITableView.automaticDimension
            tableView.estimatedSectionHeaderHeight = 50
            tableView.separatorStyle = .none
            tableView.backgroundColor = .clear
            
        }
    }
    
    let horizontalRoomIdentifier = "HorizontalRoomViewCell"
    let headerIdentifier = "HomeHeaderViewCell"
    let brokerIdentifier = "HomeBrokerViewCell"
    let verticalRoomIdentifier = "VerticalRoomItemViewCell"
    let homeDetailsIdentifier = "HomeDetailsViewController"
    var homeData: [HomeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        tableView.register(UINib(nibName: horizontalRoomIdentifier, bundle: nil), forCellReuseIdentifier: horizontalRoomIdentifier)
        tableView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellReuseIdentifier: brokerIdentifier)
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(UINib(nibName: verticalRoomIdentifier, bundle: nil), forCellReuseIdentifier: verticalRoomIdentifier)
        
        title = Constants.HomeScreen.title
        fetchHomeData()
    }
    
    private func fetchHomeData() {
        let endpoint: String = "https://admin.bstock.vn/api/v3/home"
        let headers = HTTPHeaders(["Content-Type": "application/x-www-form-urlencoded",
                                  "Accept": "application/json",
                                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzFhY2dieTZvdSIsInJvbGUiOjIsInN1YiI6IjMxYWNnYnk2b3UiLCJpc3MiOiJodHRwczovL2FkbWluLmJzdG9jay52bi9hcGkvc29jaWFsLWxvZ2luIiwiaWF0IjoxNjE1NTY0OTUzLCJleHAiOjE2MjA3NDg5NTMsIm5iZiI6MTYxNTU2NDk1MywianRpIjoiR3dMYUhUOVpmZ0g3ZEVtZSJ9.gO3sYmCiTs8YnNhRV3Y0-X_bDx0RQs5VtTsVIEKzSQ4"])
        showLoadingIndicator()
        AF.request(endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.hideLoadingIndicator()
            guard let data = response.data else { return }
            
            // this snippet code to debug if there is any mapping error
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let homeResponse = try decoder.decode(HomeResponse.self, from: data)
                self.homeData = homeResponse.data.filter({ $0.rooms.count != 0 || $0.brokers.count != 0 })
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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = homeData[section]
        switch data.itemType {
        case .room:
            if data.type == .horizontal {
                return 1
            } else {
                return data.rooms.count
            }
        case .broker:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = homeData[indexPath.section]
        switch data.itemType {
        case .room:
            if data.type == .horizontal {
                let cell = tableView.dequeueReusableCell(withIdentifier: horizontalRoomIdentifier, for: indexPath) as! HorizontalRoomViewCell
                cell.configure(rooms: data.rooms)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: verticalRoomIdentifier, for: indexPath) as! VerticalRoomItemViewCell
                cell.configure(room: data.rooms[indexPath.row])
                cell.separatorLineView.isHidden = indexPath.row == data.rooms.count - 1
                // when select on the item, it doesn't display grey color
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                return cell
            }
        case .broker:
            let cell = tableView.dequeueReusableCell(withIdentifier: brokerIdentifier, for: indexPath) as! HomeBrokerViewCell
            cell.configure(brokers: data.brokers)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = homeData[section]
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! HomeHeaderViewCell
        header.configure(title: data.title)
        header.tapHandler = { [weak self] in
            guard let self = self else { return }
            let vc = UIStoryboard.homeDetails.instantiateViewController(withIdentifier: self.homeDetailsIdentifier) as! HomeDetailsViewController
            vc.isBroker = data.itemType == .broker
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // chinh height cho footer = 0. Moi khi co header thi no tu dong co footer. nen minh phai set footer = 0
        return CGFloat.leastNonzeroMagnitude
    }
}
