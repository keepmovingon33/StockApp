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
        self.layer.masksToBounds = true
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}

@IBDesignable class CardView: UIView {
    @IBInspectable var shadowColor: UIColor = UIColor(hexString: "#DCC7FF"){
            didSet {
                updateShadow()
            }
        }
    
        public func updateShadow() {
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOffset = .zero
            layer.shadowOpacity = 6
            layer.masksToBounds = false
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            updateShadow()
        }
}
