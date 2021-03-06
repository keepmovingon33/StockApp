//
//  UIColor+Extension.swift
//  StockApp
//
//  Created by Sky on 3/5/21.
//

import UIKit

extension UIColor {
    static let lightPurpleColor = UIColor(hexString: "#9676F9")
    static let purpleColor = UIColor(hexString: "#3F27B1")
    static let grayColor = UIColor(hexString: "#8E8E93")
    static let blackColor = UIColor(hexString: "#333333")
    static let shadowColor = UIColor(hexString: "#DCC7FF")
    static let whiteTextColor = UIColor(hexString: "#FEFEFE")
    static let lightGrayColor = UIColor(hexString: "#F3F6FF")
    static let placeholderColor = UIColor(hexString: "#C7C7CD")
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
