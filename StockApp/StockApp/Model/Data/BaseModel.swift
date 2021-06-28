//
//  BaseModel.swift
//  StockApp
//
//  Created by Sky on 6/27/21.
//

import Foundation


struct BaseResponse: Decodable {
    let message: String
    let code: Int
    let data: BaseData?
}

struct BaseData: Decodable {
    
}
