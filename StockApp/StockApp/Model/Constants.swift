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
    
    struct HomeDetails {
        static let searchPlaceholder = "Tìm kiếm các broker"
        static let sorting = "Xếp hạng theo"
        static let inbox = "Nhắn Tin"
    }
    
    struct Broker {
        static let winRate = "Tỉ Lệ Thắng"
        static let interest = "Lãi Theo Tháng"
        static let totalStocks = "Tổng Số Mã"
    }
    
    struct Login {
        static let start = "BẮT ĐẦU"
        static let facebook = "Đăng Nhập Bằng Facebook"
        static let google = "Đăng Nhập Bằng Google +"
        static let apple = "Đăng Nhập Bằng Apple ID"
    }
    
    struct Warning {
        static let warning = "Lưu Ý"
        static let description = "Tài khoản đăng nhập bằng Apple ID sẽ không sử dụng được trên thiết bị android và web. Bạn có muốn tiếp tục?"
        static let check = "Không hiện thông báo lần sau"
        static let proceed = "Tiếp Tục"
    }
    
    struct Create {
        static let createStock = "Tạo Mã Cổ Phiếu Mới"
        static let createRoom = "Tạo Phòng Chat Mới"
        static let orText = "Hoặc"
        static let title = "Tạo"
    }
    
    struct CreateRoom {
        static let roomName = "Tên Phòng"
        static let roomNamePlaceholder = "Nhập Tên"
        static let note = "Ghi Chú"
        static let notePlaceholder = "Nhập Nội Dung"
        static let roomMode = "Chế Độ Phòng"
        static let roomModePublic = "Công Khai"
        static let roomModePrivate = "Riêng Tư"
        static let roomModeSecret = "Bí Mật"
        static let disclaimer = "Ai cũng có thể thấy phòng trên danh sách các phòng và có thể tham gia phòng không cần xét duyệt"
        static let finishButton = "Hoàn Thành"
        static let title = "Tạo Phòng Chat Mới"
    }
    
    struct CreateStock {
        static let stockCode = "Mã Cổ Phiếu"
        static let stockCodePlaceholder = "Nhập Mã Cổ Phiếu"
        static let price = "Giá Mua (x1000)"
        static let pricePlaceholder = "Nhập Giá Mua"
        static let holdingTime = "Thời Gian Nắm Giữ"
        static let holdingTimeValue = "Dưới 24 Tháng"
        static let note = "Ghi Chú"
        static let notePlaceholder = "Nhập Nội Dung"
        static let publish = "Đăng Vào"
        static let publishValue1 = "Phòng Duy Lê VPRO Cổ Phiếu Lướt Sóng"
        static let publishValue2 = "Phòng Đầu Tư Thắng To"
        static let publishValue3 = "Sóng To Cá Lớn"
        static let finishButton = "Hoàn Thành"
        static let title = "Tạo Mã Cổ Phiếu Mới"
        static let holdingTimePicker = "Dưới %@ tháng"
    }
}
