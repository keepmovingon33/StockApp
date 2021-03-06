//
//  AppDelegate.swift
//  StockApp
//
//  Created by Sky on 3/3/21.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var instance: AppDelegate {
        return (UIApplication.shared.delegate as! AppDelegate)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = "367758712566-93dspltee4alhau21ngm66rbtp8hqhsq.apps.googleusercontent.com"
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let facebookLogin = ApplicationDelegate.shared.application(
                                app,
                                open: url,
                                sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                annotation: options[UIApplication.OpenURLOptionsKey.annotation]
                            )
        let googleLogin = GIDSignIn.sharedInstance().handle(url)
        return facebookLogin || googleLogin
    }
}

