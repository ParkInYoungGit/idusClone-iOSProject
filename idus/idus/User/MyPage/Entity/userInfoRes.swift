//
//  userInfoRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import Foundation

struct userInfoRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [userInfoResult?]
}

// MARK: - Result
struct userInfoResult: Codable {
    let ordersIdx: Int
    let orderedDate: String
    let userIdx, addressIdx: Int
    let recipientName, recipientphone, address, deliveryStatus: String
    let payStatus, orderStatus: String
    let orderDetailIdx, itemIdx: Int
    let itemPhoto: String
    let itemName: String
    let price, purchaseQuantity: Int
    let option1Name, option1Value: String
    let option1ExtraCharge: Int
    let option2Name, option2Value: String
    let option2ExtraCharge: Int
    let option3Name, option3Value: String
    let option3ExtraCharge: Int
}
