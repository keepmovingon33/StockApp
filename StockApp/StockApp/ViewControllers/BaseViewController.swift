//
//  BaseViewController.swift
//  StockApp
//
//  Created by Sky on 3/12/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackground()
        setupSpinner()
    }
    
    private func setupBackground() {
        let bg = UIImageView(frame: self.view.bounds)
        bg.image = UIImage(named: "background")
        bg.layer.zPosition = -100
        view.addSubview(bg)
    }
    
    private func setupSpinner() {
        spinner.style = .whiteLarge
        spinner.center = self.view.center
        spinner.color = .blue
        view.addSubview(spinner)
    }
    
    func showLoadingIndicator() {
        spinner.startAnimating()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
}
