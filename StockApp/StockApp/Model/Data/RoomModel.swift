//
//  RoomModel.swift
//  StockApp
//
//  Created by Sky on 5/16/21.
//

import Foundation

struct RoomItemResponse: Decodable {
    let message: String
    let code: Int
    let data: Room?
}

struct RoomResponse: Decodable {
    let message: String
    let code: Int
    let data: RoomData
}

struct RoomData: Decodable {
    let list: [Room]
    let perPage: Int
    let total: Int
    
    enum CodingKeys: String, CodingKey {
        case list
        case total
        case perPage = "per_page"
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
    var totalStockWin: Int = 0
    let createdAt: Date?
    var updateAt: Date = Date()
    let actualHoldingTime: Double?
    let holdingTime: Double?
    let visibleSettings: VisibleSettings?
    let totalSignal: Int?
    var isActiveLately: Bool = true
    var shareLink: String = ""
    let userRoom: UserRoom?
    let owner: User?
    let member: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        ownerId = try values.decode(String.self, forKey: .ownerId)
        name = try values.decode(String.self, forKey: .name)
        desc = try? values.decode(String.self, forKey: .desc)
        avatar = try? values.decode(String.self, forKey: .avatar)
        type = try values.decode(RoomType.self, forKey: .type)
        status = try values.decode(String.self, forKey: .status)
        winRate = try? values.decode(Double.self, forKey: .winRate)
        profit = try? values.decode(Double.self, forKey: .profit)
        totalStockFinish = try? values.decode(Int.self, forKey: .totalStockFinish)
        totalStockWin = try values.decode(Int.self, forKey: .totalStockWin)
        createdAt = try? values.decode(Date.self, forKey: .createdAt)
        updateAt = try values.decode(Date.self, forKey: .updateAt)
        actualHoldingTime = try? values.decode(Double.self, forKey: .actualHoldingTime)
        holdingTime = try? values.decode(Double.self, forKey: .holdingTime)
        visibleSettings = try? values.decode(VisibleSettings.self, forKey: .visibleSettings)
        totalSignal = try? values.decode(Int.self, forKey: .totalSignal)
        shareLink = try values.decode(String.self, forKey: .shareLink)
        userRoom = try? values.decode(UserRoom.self, forKey: .userRoom)
        owner = try? values.decode(User.self, forKey: .owner)
        member = try? values.decode(Int.self, forKey: .member)
    }
    
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
    
    enum RoomStatus: String, Decodable {
        case active
        case blocked
        case requested
        case owner
        case null
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
    let created_at: Date?
    let updated_at: Date?
    let join_at: Date
    let enable_notification_stock: Bool
    let enable_notification_message: Bool
    let role_id: RoleType?
    
    enum RoleType: Int, Decodable {
        case owner = 1
        case admin = 2
        case member = 3
    }
}

