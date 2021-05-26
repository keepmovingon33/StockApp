//
//  UIApplication+Extension.swift
//  StockApp
//
//  Created by Sky on 5/25/21.
//

import UIKit

extension UIApplication {
    // func nay dung de lay Viewcontroller hien tai no dang o dau. Vi du nhu minh muon present 1 man hinh gi do, ma minh hien tai ko nam trong man hinh do, nen minh dung func topViewController nay de lay man hinh do ra
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
