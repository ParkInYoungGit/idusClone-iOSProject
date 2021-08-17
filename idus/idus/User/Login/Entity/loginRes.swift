//
//  loginRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//


struct LoginRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

// MARK: - Result
struct Result: Decodable {
    let userIdx: Int
    let jwt: String
}
