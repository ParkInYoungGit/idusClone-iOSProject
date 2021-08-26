//
//  orderRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import Foundation
struct orderRes: Decodable {
let isSuccess: Bool
let code: Int
let message: String
let result: orderResResult
}

// MARK: - Result
struct orderResResult: Decodable {
let userIdx, ordersIdx, orderDetailIdx: Int
}
