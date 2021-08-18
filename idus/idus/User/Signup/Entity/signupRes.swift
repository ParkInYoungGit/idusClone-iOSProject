//
//  signupRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import Foundation

struct SignUpRes: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

// MARK: - SignUpResult
struct SignUpResult: Decodable {
    let jwt: String
    let userIdx: Int
}
