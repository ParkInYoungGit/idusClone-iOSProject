//
//  reviewRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/25.
//

import Foundation

// MARK: - Mypage
struct reviewRes: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [reviewResult?]
}

// MARK: - Result
struct reviewResult: Codable {
    let reviewIdx, itemIdx, orderIdx: Int
    let createdDate: String
    let userProfile: String?
    let userName: String
    let rate: Int
    let option1Name, option1Value, option2Name, option2Value: String
    let option3Name, option3Value, reviewContent: String
    let reviewPhoto: String?
}
