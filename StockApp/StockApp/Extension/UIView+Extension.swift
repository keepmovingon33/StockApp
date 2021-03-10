//
//  UIView+Extension.swift
//  StockApp
//
//  Created by Sky on 3/6/21.
//

import UIKit

extension UIView {
    func setBorderRadius(with radius: CGFloat, color: UIColor = .clear, width: CGFloat = 0) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        // khi masksToBounds = true nghia la nhung cai view khac ko duoc trao ra khoi view do. Nen minh dung view nay de tao border. Va view border luon luon la lop ben trong
        self.layer.masksToBounds = true
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        // khi masksToBounds = false thi minh moi set shadow duoc boi vi nhung view minh tao ra duoc trao ra khoi view do. Va view shadow luon luon la lop ben ngoai
        self.layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
      }
}
