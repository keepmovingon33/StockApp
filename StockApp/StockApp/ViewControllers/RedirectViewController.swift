//
//  RedirectViewController.swift
//  StockApp
//
//  Created by Sky on 5/29/21.
//

import Alamofire
import UIKit

class RedirectViewController: BaseViewController {

    @IBOutlet weak var backgroundImage: UIImageView! {
        didSet {
            backgroundImage.image = #imageLiteral(resourceName: "loginBG")
            backgroundImage.contentMode = .scaleAspectFill
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        redirectUI()
    }
    
    private func redirectUI(){
        let token = CurrentSession.instance.accessToken
        if token.isEmpty {
            AppDelegate.instance.switchToLoginViewController()
            return
        }
        
        // Check if token is expired
        getUserDetail(token: token)
    }
    
    // func check if token is expired
    private func getUserDetail(token: String) {
        let endpoint: String = "https://admin.bstock.vn/api/user"
        let headers = HTTPHeaders(["Content-Type": "application/x-www-form-urlencoded",
                                  "Accept": "application/json",
//                                  "Authorization": "Bearer \(token)"
                                  "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMzFhY2dieTZvdSIsInJvbGUiOjIsInN1YiI6IjMxYWNnYnk2b3UiLCJpc3MiOiJodHRwczovL2FkbWluLmJzdG9jay52bi9hcGkvc29jaWFsLWxvZ2luIiwiaWF0IjoxNjIxMTIwOTk2LCJleHAiOjE2MjYzMDQ5OTYsIm5iZiI6MTYyMTEyMDk5NiwianRpIjoidG5NSVJzNmw0M0lTMDRpMyJ9.fdvleFdSNY_nkWvEAs8vWTzj9-JCAgMDCPVxROVooi4"
        ])
        showLoadingIndicator()
        AF.request(endpoint, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            self.hideLoadingIndicator()
            guard let data = response.data else { return }
            
            // this snippet code to debug if there is any mapping error
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let userResponse = try decoder.decode(UserResponse.self, from: data)
                if let user = userResponse.data {
                    // save user info into current session
                    CurrentSession.instance.user = user
                    AppDelegate.instance.switchToHomeViewController()
                } else {
                    AppDelegate.instance.switchToLoginViewController()
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
}
