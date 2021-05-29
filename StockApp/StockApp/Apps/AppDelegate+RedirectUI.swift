//
//  AppDelegate+RedirectUI.swift
//  StockApp
//
//  Created by Sky on 5/29/21.
//

import UIKit

extension AppDelegate {
    func switchToHomeViewController() {
        let viewController = UIStoryboard.home
            .instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let nav = BaseNavigationController(rootViewController: viewController)
        UIApplication.shared.windows.first?.rootViewController = nav
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func switchToLoginViewController() {
        let viewController = UIStoryboard.login
            .instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
