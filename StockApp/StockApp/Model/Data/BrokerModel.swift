//
//  BrokerModel.swift
//  StockApp
//
//  Created by Sky on 3/24/21.
//

import Foundation

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
    let name: String
    let email: String?
    let roleId: Int
    let provider: String
    let providerId: String
    let avatar: String
    let enableNotification: Bool
    let createdAt: Date
    let updatedAt: Date
    let winRate: Double?
    let profit: Double?
    let totalStockFinish: Int?
    let totalStockWin: Int
    let holdingTime: Double
    let roomCount: Int
    let totalSignal: Int
    let visibleSetting: VisibleSettings
    let phone: String?
    let gender: String?
    let birthday: Date?
    let desc: String?
    let isActiveLately: Bool
    
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
