//
//  detailViesRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import Foundation

struct detailViewRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: detailResult?
}

// MARK: - Result
struct detailResult: Decodable {
    let itemIdx, sellerIdx: Int
    let sellerName: String
    let sellerProfile: String
    let category, name: String
    let price, rateOfDiscount, reducedPrice: Int
    let averageRate: Double
    let numOfReview, numOfCustomer, numOfLikes, deliveryCharge: Int
    let freeShippingCondition: Int
    let deliveryDay: String
    let totalStock: Int
    let content, prodPolicyName, prodPolicyDetail, refundPolicyName: String
    let refundPolicyDetail: String
}
