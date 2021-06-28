//
//  BrokerModel.swift
//  StockApp
//
//  Created by Sky on 3/24/21.
//

import Foundation

struct UserResponse: Decodable {
    let message: String
    let code: Int
    let data: User?
}

struct BrokerResponse: Decodable {
    let message: String
    let code: Int
    let data: BrokerData
}

struct BrokerData: Decodable {
    let list: [User]
    let perPage: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case list
        case total
        case perPage = "per_page"
    }
}

struct User: Decodable {
    let id: String
    var name: String = ""
    let email: String?
    var roleId: Int
    let provider: String?
    let providerId: String?
    let avatar: String?
    var enableNotification: Bool = true
    let createdAt: Date?
    let updatedAt: Date?
    let winRate: Double?
    let profit: Double?
    let totalStockFinish: Int?
    var totalStockWin: Int = 0
    var holdingTime: Double = 0
    var roomCount: Int? = 0
    var totalSignal: Int = 0
    let visibleSetting: VisibleSettings?
    let phone: String?
    let gender: String?
    let birthday: Date?
    let desc: String?
    var isActiveLately: Bool = true
    let ownRooms: [Room]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        email = try? values.decode(String.self, forKey: .email)
        roleId = try values.decode(Int.self, forKey: .roleId)
        provider = try? values.decode(String.self, forKey: .provider)
        providerId = try? values.decode(String.self, forKey: .providerId)
        avatar = try? values.decode(String.self, forKey: .avatar)
        enableNotification = try values.decode(Bool.self, forKey: .enableNotification)
        createdAt = try? values.decode(Date.self, forKey: .createdAt)
        updatedAt = try? values.decode(Date.self, forKey: .updatedAt)
        winRate = try? values.decode(Double.self, forKey: .winRate)
        profit = try? values.decode(Double.self, forKey: .profit)
        totalStockFinish = try? values.decode(Int.self, forKey: .totalStockFinish)
        totalStockWin = try values.decode(Int.self, forKey: .totalStockWin)
        holdingTime = try values.decode(Double.self, forKey: .holdingTime)
        roomCount = try values.decode(Int.self, forKey: .roomCount)
        totalSignal = try values.decode(Int.self, forKey: .totalSignal)
        visibleSetting = try? values.decode(VisibleSettings.self, forKey: .visibleSetting)
        phone = try? values.decode(String.self, forKey: .phone)
        gender = try? values.decode(String.self, forKey: .gender)
        birthday = try? values.decode(Date.self, forKey: .birthday)
        desc = try? values.decode(String.self, forKey: .desc)
        isActiveLately = try values.decode(Bool.self, forKey: .isActiveLately)
        ownRooms = try? values.decode([Room].self, forKey: .ownRooms)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case roleId = "role_id"
        case provider
        case providerId = "provider_id"
        case avatar
        case enableNotification = "enable_notification"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case winRate = "avg_winrate"
        case profit = "avg_profit"
        case totalStockFinish = "total_stock_code_finish"
        case totalStockWin = "total_stock_code_win"
        case holdingTime = "avg_holding_time"
        case roomCount = "room_count"
        case totalSignal = "total_signal"
        case visibleSetting = "visible_settings"
        case phone
        case gender
        case birthday
        case desc = "description"
        case isActiveLately = "is_active_lately"
        case ownRooms = "own_rooms"
    }
    
    enum RoleId: Int, Decodable {
        case owner = 1
        case admin = 2
        case member = 3
    }
    
    struct VisibleSettings: Decodable {
        let winRate: Int
        let profit: Int
        let totalSignal: Int
        let birthday: Int
        let gender: Int
        let email: Int
        let phone: Int
        
        enum CodingKeys: String, CodingKey {
            case winRate = "avg_winrate"
            case profit = "avg_profit"
            case totalSignal = "total_signal"
            case birthday
            case gender
            case email
            case phone
        }
    }
}
