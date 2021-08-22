//
//  todayViewDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/22.
//

import Foundation

import Alamofire

class todayViewDataManager {
    func getProduct(delegate: SecondTableViewCell) {
        AF.request("\(Constant.BASE_URL)items", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: todayRes.self) { response in
                print("response result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    delegate.didSuccessProduct(data: response)
                        print("todayViewSuccess>>>>>>>>>>\(response.result)")
                        print("todayViewSuccess>>>>>>>>>>\(response.message)")
                        
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
                    print("todayViewFail>>>>>>>>>>>>>>\(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
