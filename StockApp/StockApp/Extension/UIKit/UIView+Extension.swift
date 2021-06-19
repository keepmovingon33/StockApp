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

extension UIView {
    func setGradientBackground() {
        let colorTop =  UIColor.init(hexString: "#607AE2").cgColor
        let colorBottom = UIColor.init(hexString: "#9A71E7").cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
//        gradientLayer.locations = [0.0, 1.0] // color change from top to bottom
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5); // color change from left to right
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5);
        gradientLayer.frame = self.bounds
                
        self.layer.insertSublayer(gradientLayer, at:0)
    }
}
