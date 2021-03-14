//
//  HomeModel.swift
//  StockApp
//
//  Created by Sky on 3/12/21.
//

import Foundation

struct HomeResponse: Decodable {
    let message: String
    let code: Int
    let data: [HomeData]
}

struct HomeData: Decodable {
    let type: HomeType
    let title: String
    let url: String?
    let itemType: ItemType
    let isMyRoom: Bool?
    var rooms: [Room] = []
    var brokers: [User] = []
    
    enum CodingKeys: String, CodingKey {
        case type
        case title
        case url
        case brokers
        case rooms
        case itemType = "item_type"
        case isMyRoom = "is_my_room"
    }
    
    // ham init nay minh su dung khi minh muon set gia tri empty array cho rooms va brokers
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decode(HomeType.self, forKey: .type)
        title = try values.decode(String.self, forKey: .title)
        url = try? values.decode(String.self, forKey: .url)
        itemType = try values.decode(ItemType.self, forKey: .itemType)
        isMyRoom = try? values.decode(Bool.self, forKey: .isMyRoom)
        rooms = (try? values.decode([Room].self, forKey: .rooms)) ?? []
        brokers = (try? values.decode([User].self, forKey: .brokers)) ?? []
    }
    
    enum HomeType: String, Decodable {
        case horizontal
        case vertical
    }
    
    enum ItemType: String, Decodable {
        case room
        case broker
    }
}

struct Room: Decodable {
    let id: String
    let ownerId: String
    let name: String
    let desc: String?
    let avatar: String?
    let type: RoomType
    let status: String
    let winRate: Double?
    let profit: Double?
    let totalStockFinish: Int?
    let totalStockWin: Int
    let createdAt: Date?
    let updateAt: Date
    let actualHoldingTime: Double?
    let holdingTime: Double?
    let visibleSettings: VisibleSettings
    let totalSignal: Int?
    let isActiveLately: Bool
    let shareLink: String
    let userRoom: UserRoom?
    let owner: User?
    let member: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case avatar
        case type
        case status
        case owner
        case ownerId = "owner_id"
        case desc = "description"
        case winRate = "avg_winrate"
        case profit = "avg_profit"
        case totalStockFinish = "total_stock_code_finish"
        case totalStockWin = "total_stock_code_win"
        case createdAt = "created_at"
        case updateAt = "updated_at"
        case actualHoldingTime = "avg_actual_holding_time"
        case holdingTime = "avg_holding_time"
        case visibleSettings = "visible_settings"
        case totalSignal = "total_signal"
        case isActiveLately = "is_active_lately"
        case shareLink = "share_link"
        case userRoom = "user_room"
        case member
    }
    
    enum RoomType: String, Decodable {
        case publication = "public"
        case privacy = "private"
        case closed = "closed"
    }
    
    struct VisibleSettings: Decodable {
        let createdAt: Int
        let winRate: Int
        let profit: Int
        let totalStockFinish: Int
        let member: Int
        let actualHoldingTime: Int
        let holdingTime: Int
        let totalSignal: Int?
        
        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case winRate = "avg_winrate"
            case profit = "avg_profit"
            case totalStockFinish = "total_stock_code_finish"
            case member
            case actualHoldingTime = "avg_actual_holding_time"
            case holdingTime = "avg_holding_time"
            case totalSignal = "total_signal"
        }
    }
    
    func isInRoom() -> Bool {
        return userRoom != nil
    }
    
    func isRoomOwner() -> Bool {
        return isInRoom() && userRoom?.role_id == .owner
    }
    
    func isRoomAdmin() -> Bool {
        return isInRoom() && userRoom?.role_id == .admin
    }
    
    func isRoomMember() -> Bool {
        return isInRoom() && userRoom?.role_id == .member
    }
}

struct UserRoom: Decodable {
    let id: Int
    let user_id: String
    let room_id: String
    let status: String
    let expired_at: Date?
    let created_at: Date
    let updated_at: Date
    let join_at: Date
    let enable_notification_stock: Bool
    let enable_notification_message: Bool
    let role_id: RoleType
    
    enum RoleType: Int, Decodable {
        case owner = 1
        case admin = 2
        case member = 3
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
