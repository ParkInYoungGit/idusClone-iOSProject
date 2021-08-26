//
//  orderInfoRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import Foundation

struct orderInfoRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [orderInfoResult]?
}

// MARK: - Result
struct orderInfoResult: Decodable {
    let userIdx: Int?
    let userName, userPhone: String?
    let addressNumber, addressIdx: Int?
    let recipientName, recipientPhone, address: String?
}
