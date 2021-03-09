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
    
    override func viewDidLoad() {
        super.viewDidLoad()      
        tableView.register(UINib(nibName: joiningRoomIdentifier, bundle: nil), forCellReuseIdentifier: joiningRoomIdentifier)
        tableView.register(UINib(nibName: brokerIdentifier, bundle: nil), forCellReuseIdentifier: brokerIdentifier)
        tableView.register(UINib(nibName: headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerIdentifier)
        
    }
    
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: joiningRoomIdentifier, for: indexPath) as! JoiningRoomViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: joiningRoomIdentifier, for: indexPath) as! JoiningRoomViewCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier) as! HomeHeaderViewCell
        if section == 0 {
            header.configure(title: "Phong Dang Tham Gia")
        } else {
            header.configure(title: "Ket Noi Voi Cac Broker Noi Bat")
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // chinh height cho footer = 0. Moi khi co header thi no tu dong co footer. nen minh phai set footer = 0
        return CGFloat.leastNonzeroMagnitude
    }
}
