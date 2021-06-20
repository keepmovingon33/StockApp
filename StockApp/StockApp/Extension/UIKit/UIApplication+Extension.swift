//
//  UIApplication+Extension.swift
//  StockApp
//
//  Created by Sky on 5/25/21.
//

import UIKit

extension UIApplication {
    // func nay dung de lay Viewcontroller hien tai no dang o dau. Boi vi khi minh viet nhung function helper de display 1 cai gi do tren cai man hinh hien tai, minh ko the goi self.present duoc. Nen minh can cai func nay de lay ra duoc viewcontroller hien tai, va tu do present alert
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
