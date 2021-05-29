//
//  BaseNavigationController.swift
//  StockApp
//
//  Created by Sky on 5/28/21.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .white
        navigationBar.tintColor = UIColor.purpleColor
        navigationBar.titleTextAttributes = TextFormatting.purpleHeader
        
        // lam mat duong line giua navbar voi view
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
}
