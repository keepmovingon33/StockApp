//
//  LoginModel.swift
//  StockApp
//
//  Created by Sky on 5/26/21.
//

import Foundation

struct LoginResponse: Decodable {
    let message: String
    let code: Int
    let data: LoginData?
}

struct LoginData: Decodable {
    let token: String
    let user: User
    let version: String?
}
