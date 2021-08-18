//
//  myPageRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/19.
//


// MARK: - Mypage

import Foundation

// MARK: - Mypage
struct myPageRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: myPageResult?
}

// MARK: - Result
struct myPageResult: Decodable {
    let userIdx: Int
    let userName, password, email, phone: String
    let membership: String
    let profilePhoto, birthdate, gender, recommenderID: String?

}
