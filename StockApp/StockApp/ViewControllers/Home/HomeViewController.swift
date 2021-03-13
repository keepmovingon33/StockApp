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
    
    let joiningRoomIdentifier = "JoiningRoomViewCell"
    let headerIdentifier = "HomeHeaderViewCell"
    let brokerIdentifier = "HomeBrokerViewCell"
    let roomIdentifier = "RoomItemViewCell"
    let homeDetailsIdentifier = "HomeDetailsViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        tableView.register(UINib(nibName: joiningRoomIdentifier, bundle: nil), forCellReuseIdentifier: joiningRoomIdentifier)
        tableView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellReuseIdentifier: brokerIdentifier)
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(UINib(nibName: roomIdentifier, bundle: nil), forCellReuseIdentifier: roomIdentifier)
        
        title = Constants.HomeScreen.title
        fetchHomeData()
    }
    
    private func fetchHomeData() {
        let endpoint: String = "https://admin.bstock.vn/api/v3/home"
        let headers = HTTPHeaders(["Content-Type": "application/x-www-form-urlencoded",
                                  "Accept": "application/json",
                                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzFhY2dieTZvdSIsInJvbGUiOjIsInN1YiI6IjMxYWNnYnk2b3UiLCJpc3MiOiJodHRwczovL2FkbWluLmJzdG9jay52bi9hcGkvc29jaWFsLWxvZ2luIiwiaWF0IjoxNjE1NTY0OTUzLCJleHAiOjE2MjA3NDg5NTMsIm5iZiI6MTYxNTU2NDk1MywianRpIjoiR3dMYUhUOVpmZ0g3ZEVtZSJ9.gO3sYmCiTs8YnNhRV3Y0-X_bDx0RQs5VtTsVIEKzSQ4"])
        AF.request(endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { data in
            print(data)
            switch data.result {
            case let .success(value):
                do {
                    let decoder = JSONDecoder()
                    let messages = try decoder.decode(HomeResponse.self, from: value as! Data)
                    print(messages as Any)
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
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: joiningRoomIdentifier, for: indexPath) as! JoiningRoomViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: brokerIdentifier, for: indexPath) as! HomeBrokerViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: roomIdentifier, for: indexPath) as! RoomItemViewCell
            cell.configure()
            cell.separatorLineView.isHidden = indexPath.row == 2
            // when select on the item, it doesn't display grey color
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! HomeHeaderViewCell
        switch section {
        case 0:
            header.configure(title: "Phong Dang Tham Gia")
        case 1:
            header.configure(title: "Ket Noi Voi Cac Broker Noi Bat")
            header.tapHandler = { [weak self] in
                guard let self = self else { return }
                let vc = UIStoryboard.homeDetails.instantiateViewController(withIdentifier: self.homeDetailsIdentifier)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case 2:
            header.configure(title: "Phong Rieng")
            header.tapHandler = { [weak self] in
                guard let self = self else { return }
                let vc = UIStoryboard.homeDetails.instantiateViewController(withIdentifier: self.homeDetailsIdentifier) as! HomeDetailsViewController
                vc.isBroker = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
        default:
            header.configure(title: "Phong Cong Khai")
            header.tapHandler = { [weak self] in
                guard let self = self else { return }
                let vc = UIStoryboard.homeDetails.instantiateViewController(withIdentifier: self.homeDetailsIdentifier) as! HomeDetailsViewController
                vc.isBroker = false
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // chinh height cho footer = 0. Moi khi co header thi no tu dong co footer. nen minh phai set footer = 0
        return CGFloat.leastNonzeroMagnitude
    }
}
