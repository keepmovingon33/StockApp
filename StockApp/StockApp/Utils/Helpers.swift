//
//  Helpers.swift
//  StockApp
//
//  Created by Sky on 5/25/21.
//

import UIKit

class Helpers {
    static func showAlert(title: String = "StockApp", message: String, actionTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
}
