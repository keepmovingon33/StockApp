//
//  BaseViewController.swift
//  StockApp
//
//  Created by Sky on 3/12/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
    }
    
    func setupBackground() {
        let bg = UIImageView(frame: self.view.bounds)
        bg.image = UIImage(named: "background")
        bg.layer.zPosition = -100
        view.addSubview(bg)
    }

}
