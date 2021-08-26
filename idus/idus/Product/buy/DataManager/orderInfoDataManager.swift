//
//  orderInfoDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import Foundation
import Alamofire

class orderInfoDataManager {
    
    let header: HTTPHeaders = [
        "x-access-token" : Constant.shared.jwt]

//    let header: HTTPHeaders = [
//        "x-access-token" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo0LCJpYXQiOjE2Mjk5NDQyOTYsImV4cCI6MTYzMTQxNTUyNX0.vIClVN0soce2nq34L6OpDHHIpVT_4lK8drRsnNzwvjc"
//    ]
    
    func getOrderInfo(delegate: buyViewController) {
        AF.request("\(Constant.BASE_URL)users/info/4/addrInfo", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: orderInfoRes.self) { response in
                print("response result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if let result = response.result {
                    delegate.didSuccessOrderInfo(result)
                    }
                        print("orderInfo>>>>>>>>>>\(response.result)")
                        print("orderInfo>>>>>>>>>>\(response.message)")

                    // 실패했을 때
//                    else {
//                        switch response.code {
//                        case 2000: delegate.failedToRequest(message: "상황에 맞는")
//                        case 3000: delegate.failedToRequest(message: "에러 메시지로")
//                        case 4000: delegate.failedToRequest(message: "사용자에게 적절한")
//                        default: delegate.failedToRequest(message: "피드백을 주세요")
//                        }
//                    }
                case .failure(let error):
                    print("orderInfo>>>>>>>>>>>>>>\(error.localizedDescription)")
                    delegate.failedToRequestOrderInfo(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
