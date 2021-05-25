//
//  LoginViewController.swift
//  StockApp
//
//  Created by Sky on 5/19/21.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var facebookLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setupBackground()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupShadow()
    }
    
    private func configureUI() {
        logoImageView.image = UIImage(named: "logo")
        startLabel.attributedText = NSAttributedString(string: Constants.Login.start, attributes: TextFormatting.whiteText)
        facebookLoginButton.setAttributedTitle(NSAttributedString(string: Constants.Login.facebook, attributes: TextFormatting.purpleButtonText), for: .normal)
        facebookLoginButton.backgroundColor = .white
        googleLoginButton.setAttributedTitle(NSAttributedString(string: Constants.Login.google, attributes: TextFormatting.purpleButtonText), for: .normal)
        googleLoginButton.backgroundColor = .white
        appleLoginButton.setAttributedTitle(NSAttributedString(string: Constants.Login.apple, attributes: TextFormatting.purpleButtonText), for: .normal)
        appleLoginButton.backgroundColor = .white
    }
    
    private func setupBackground() {
        let bg = UIImageView(frame: self.view.bounds)
        bg.image = UIImage(named: "loginBG")
        bg.layer.zPosition = -100
        view.addSubview(bg)
    }
    
    private func setupShadow() {
        facebookLoginButton.setBorderRadius(with: 8)
        facebookLoginButton.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 0.5, offSet: CGSize(width: 0.25, height: 0.25), radius: 8)
        googleLoginButton.setBorderRadius(with: 8)
        googleLoginButton.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 0.5, offSet: CGSize(width: 0.25, height: 0.25), radius: 8)
        appleLoginButton.setBorderRadius(with: 8)
        appleLoginButton.dropShadow(color: UIColor.init(hexString: "#DCC7FF"), opacity: 0.5, offSet: CGSize(width: 0.25, height: 0.25), radius: 8)
    }
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        let login = LoginManager()
        login.logIn(permissions: ["email"], from: self) { (result, error) in
            if let e = error {
                print("process error \(e.localizedDescription)")
            } else if let result = result {
                if result.isCancelled {
                    print("canceled")
                } else {
                    print("Logged in with token \(result.token)")
                }
            }
        }
    }
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func appleButtonTapped(_ sender: Any) {
        if !UserDefaults.standard.bool(forKey: "NotShowingAppleWarning") {
            let vc = UIStoryboard.login.instantiateViewController(withIdentifier: "WarningViewController")
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        } else {
            print("hello")
        }
    }
}

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            print("show error")
        } else {
            if let token = user.authentication.accessToken {
                print(token)
            }
        }
    }
}
