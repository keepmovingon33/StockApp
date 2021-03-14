//
//  UIImageView+Extension.swift
//  StockApp
//
//  Created by Sky on 3/13/21.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImageWith(urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }
        self.kf.setImage(with: url, placeholder: placeholder)
    }
}
