//
//  CurrentSession.swift
//  StockApp
//
//  Created by Sky on 5/29/21.
//

import Foundation

class CurrentSession: NSObject {
    private static let _instance = CurrentSession()
    public static var instance: CurrentSession {
        return _instance
    }
    
    public var user: User?
    public var accessToken: String {
        get {
            return UserDefaults.standard.string(forKey: "Access Token") ?? ""
        }
        set(value) {
            UserDefaults.standard.setValue(value, forKey: "Access Token")
        }
    }
    
    public func cleanUp() {
        user = nil
        accessToken = ""
    }
}
