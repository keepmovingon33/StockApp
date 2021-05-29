//
//  WarningViewController.swift
//  StockApp
//
//  Created by Sky on 5/19/21.
//

import UIKit

class WarningViewController: UIViewController {
    @IBOutlet weak var closeImage: UIImageView!
    @IBOutlet weak var warningImageView: UIImageView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var checkboxLabel: UILabel!
    @IBOutlet weak var lineSeparatorView: UIView! {
        didSet {
            lineSeparatorView.backgroundColor = UIColor.shadowColor
        }
    }
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var checkboxView: UIView!
    
    var continueHandler: SimpleCompletion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupShadow()
    }
    
    private func configureUI() {
        closeImage.image = UIImage(named: "close")
        warningImageView.image = UIImage(named: "warning")
        warningLabel.attributedText = NSAttributedString(string: Constants.Warning.warning, attributes: TextFormatting.purpleMediumText)
        warningLabel.textAlignment = .center
        descriptionLabel.attributedText = NSAttributedString(string: Constants.Warning.description, attributes: TextFormatting.blackRegularTitle)
        descriptionLabel.textAlignment = .center
        checkBoxImageView.image = UIImage(named: "checkbox")
        checkboxLabel.attributedText = NSAttributedString(string: Constants.Warning.check, attributes: TextFormatting.purpleValue)
        proceedButton.setAttributedTitle(NSAttributedString(string: Constants.Warning.proceed, attributes: TextFormatting.purpleButtonText), for: .normal)
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeButtonTapped(_:)))
        closeImage.addGestureRecognizer(tap)
        closeImage.isUserInteractionEnabled = true
    }

    private func setupShadow() {
        warningView.setBorderRadius(with: 8)
        warningView.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 0.5, offSet: CGSize(width: 0.5, height: 0.5), radius: 8)
    }
    
    @objc func closeButtonTapped(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        let value = checkBoxImageView.image == UIImage(named: "checked") ? true : false
        UserDefaults.standard.set(value, forKey: "NotShowingAppleWarning")
        self.dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            self.continueHandler?()
        })
    }
    
    
    @IBAction func checkboxTapped(_ sender: Any) {
        if checkBoxImageView.image == UIImage(named: "checkbox") {
            checkBoxImageView.image = UIImage(named: "checked")
        } else {
            checkBoxImageView.image = UIImage(named: "checkbox")
        }
    }
}
