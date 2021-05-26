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
    let data: LoginData
}

struct LoginData: Decodable {
    let token: String
    let user: User
    let version: String?
    
    enum CodingKeys: String, CodingKey {
        case token
        case user
        case version
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decode(String.self, forKey: .token)
        user = try values.decode(User.self, forKey: .user)
        version = try? values.decode(String.self, forKey: .version)
    }
}
