//
//  Enums.swift
//  StockApp
//
//  Created by Sky on 5/16/21.
//

import Foundation

enum FilterType: String, CaseIterable {
    case all = "Tất Cả"
    case oneMonth = "1 Tháng Gần Đây"
    case threeMonths = "3 Tháng Gần Đây"
    case sevenMonths = "7 Tháng Gần Đây"
}

enum HoldingType: String, CaseIterable {
    case twoyears = "Dưới 24 Tháng"
    case oneyear = "Dưới 12 Tháng"
    case sixmonths = "Dưới 6 Tháng"
}

enum SortingType: String, CaseIterable {
    case avg_winrate = "Tỉ Lệ Thắng"
    case member = "Số Thành Viên"
    case total_signal = "Số Mã CP Đã Phím"
    case avg_holding_time = "Thời Gian Đầu Tư"
    case avg_profit = "Lợi Nhuận"
    
    static let roomCase = allCases
    static let brokerCase = [avg_winrate, avg_profit]
}


