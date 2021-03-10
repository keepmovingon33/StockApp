//
//  HomeViewController.swift
//  StockApp
//
//  Created by Sky on 3/7/21.
//

import UIKit

class HomeViewController: UIViewController {

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
            
        }
    }
    
    let joiningRoomIdentifier = "JoiningRoomViewCell"
    let headerIdentifier = "HomeHeaderViewCell"
    let brokerIdentifier = "HomeBrokerViewCell"
    let roomIdentifier = "RoomItemViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        tableView.register(UINib(nibName: joiningRoomIdentifier, bundle: nil), forCellReuseIdentifier: joiningRoomIdentifier)
        tableView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellReuseIdentifier: brokerIdentifier)
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        tableView.register(UINib(nibName: roomIdentifier, bundle: nil), forCellReuseIdentifier: roomIdentifier)
        
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
        case 2:
            header.configure(title: "Phong Rieng")
        default:
            header.configure(title: "Phong Cong Khai")
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // chinh height cho footer = 0. Moi khi co header thi no tu dong co footer. nen minh phai set footer = 0
        return CGFloat.leastNonzeroMagnitude
    }
}
