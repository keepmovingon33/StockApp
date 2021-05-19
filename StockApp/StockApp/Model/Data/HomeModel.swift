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
