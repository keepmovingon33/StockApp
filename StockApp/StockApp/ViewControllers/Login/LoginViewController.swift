//
//  LoginViewController.swift
//  StockApp
//
//  Created by Sky on 5/19/21.
//

import UIKit
import Alamofire
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit
import AuthenticationServices

class LoginViewController: BaseViewController {

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
            if let result = result, let token = result.token?.tokenString {
                self.callLoginAPI(provider: "facebook", accessToken: token)
            } else {
                Helpers.showAlert(message: "Facebook Login Cancelled")
            }
        }
    }
    
    @IBAction func googleButtonTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    @IBAction func appleButtonTapped(_ sender: Any) {
        // if user has not clicked to turn off the popup
        if !UserDefaults.standard.bool(forKey: "NotShowingAppleWarning") {
            let vc = UIStoryboard.login.instantiateViewController(withIdentifier: "WarningViewController") as! WarningViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.continueHandler = { [weak self] in
                self?.appleSignedIn()
            }
            self.present(vc, animated: true, completion: nil)
        } else { // if user has clicked to turn off the popup, we will handle the login
            appleSignedIn()
        }
    }
    
    private func callLoginAPI(provider: String, accessToken: String) {
        let endpoint: String = "https://admin.bstock.vn/api/social-login"
        let headers = HTTPHeaders(["Content-Type": "application/json",
                                  "Accept": "application/json"])
        let parameters = [
            "one_signal_id" : "",
            "provider" : provider,
            "platform" : "iOS",
            "access_token" : accessToken
        ] as [String : Any]
        showLoadingIndicator()
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                    self.hideLoadingIndicator()
                    guard let data = response.data else { return }
            
            // this snippet code to debug if there is any mapping error
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                if let data = loginResponse.data {
                    // save user
                    CurrentSession.instance.user = data.user
                    // save token
                    CurrentSession.instance.accessToken = data.token
                    AppDelegate.instance.switchToHomeViewController()
                }
                
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
        }
    }
    
    
    private func appleSignedIn() {
        // Handle Apple login
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            Helpers.showAlert(message: "device is not supported for Apple login")
        }
        
    }
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

extension LoginViewController: GIDSignInDelegate {
    // Handle Google login callback
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let token = user.authentication.accessToken {
            callLoginAPI(provider: "google", accessToken: token)
        } else {
            Helpers.showAlert(message: error.localizedDescription)
        }
    }
}

@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential, let accessToken = appleIDCredential.identityToken, let token = String(data: accessToken, encoding: .utf8) {
            callLoginAPI(provider: "apple", accessToken: token)
        } else {
            Helpers.showAlert(message: "Login failed")
        }
    }
    
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        Helpers.showAlert(message: "Apple Login Failed")
    }
}
