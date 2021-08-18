//
//  Constant.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import Foundation
import Alamofire

class Constant {
    static let BASE_URL = "https://rpann.shop/app/"
    static let shared = Constant()
    private init(){
        
    }
    var jwt: String = ""
    var idx: Int = 0

}

// 이렇게 접근 Constant.shared.jwt
