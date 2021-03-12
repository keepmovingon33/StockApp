//
//  Constants.swift
//  StockApp
//
//  Created by Sky on 3/5/21.
//

import Foundation

typealias SimpleCompletion = (() -> Void)

struct Constants {
    struct RoomDetails {
        static let editButton = "Sửa"
        static let createdTime = "Thời gian hoạt động"
        static let winRate = "Tỷ lệ thắng"
        static let totalStock = "Tổng số mã đã đóng"
        static let totalMember = "Số thành viên"
        static let estimatedTime = "Thời gian nắm giữ ước tính"
        static let actualTime = "Thời gian nắm giữ thực tế"
        static let description = "Miêu tả"
        
        static let roomMode = "Chế độ phòng"
        static let displaySetting = "Cài đặt hiển thị"
        static let messageSearch = "Tìm tin nhắn"
        static let memberList = "Danh sách thành viên"
        static let memberBlock = "Người dùng bị chặn"
        static let suggestionNoti = "Thông báo khi có khuyến nghị mới"
        static let messageNoti = "Thông báo khi có tin nhắn mới"
        static let report = "Báo Cáo"
        static let leave = "Rời Phòng"
        static let publicMode = "Công Khai"
        static let privateMode = "Riêng Tư"
        static let secretMode = "Bí Mật"
        static let requestButton = "Yêu Cầu"
        
    }
    
    struct HomeScreen {
        static let title = "Cộng Đồng"
    }
    
    struct Brokers {
        static let searchPlaceholder = "Tìm kiếm các broker"
        static let sorting = "Xếp hạng theo"
        static let inbox = "Nhắn Tin"
        static let title = "Các Broker"
    }
}
