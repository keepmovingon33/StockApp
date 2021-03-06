//
//  Formatting.swift
//  StockApp
//
//  Created by Sky on 3/5/21.
//

import UIKit

struct TextFormatting {
    static let blackHeader: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .medium), .foregroundColor:  UIColor(hexString: "#333333")]
    static let blackTitle: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor:  UIColor(hexString: "#333333")]
    static let greyValue: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor:  UIColor(hexString: "#8E8E93")]
    static let purpleValue: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor:  UIColor(hexString: "#3F27B1")]
    static let purpleButtonText: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 14, weight: .semibold), .foregroundColor:  UIColor(hexString: "#3F27B1")]
}


