//
//  signupReq.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import Foundation

struct SignupReq: Encodable {
    let userName, password, email, phone: String
}

