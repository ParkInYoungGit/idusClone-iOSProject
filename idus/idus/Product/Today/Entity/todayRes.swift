//
//  todayRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/22.
//

import Foundation


// MARK: - Mypage
struct todayRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: todayResult?
}

// MARK: - Result
struct todayResult: Decodable {
    let itemIdx: Int
    let category, itemName, sellerName: String
    let itemPhotoURL: String
    let averageRate: Double
    let newReview: String
    let numOfReview: Int
}
