//
//  optionRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import Foundation

// MARK: - Mypage
struct optionRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [optionResult]
}

// MARK: - Result
struct optionResult: Decodable {
    let optionIdx, itemIdx, optionNum: Int
    let optionName, optionValue: String
    let stockQuantity, extraCharge: Int
}
