//
//  File.swift
//  idus
//
//  Created by YOUNG on 2021/08/25.
//

import Foundation

import Alamofire

class reviewDataManager {
    func getProductReview(productNum: Int, delegate: reviewTableViewCell) {
        AF.request("\(Constant.BASE_URL)items/\(productNum)/reviews", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: reviewRes.self) { response in
                print("response result >>> \(response.result)")
                print("printdetail URL\(Constant.BASE_URL)\(productNum)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                    delegate.didSuccessProductReview(data: response)
                        print("review>>>>>>>>>>\(response.result)")
                        print("review>>>>>>>>>>\(response.message)")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 4000: delegate.failedToRequest(message: "데이터베이스 연결에 실패했습니다.")
                        default: delegate.failedToRequest(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print("review>>>>>>>>>>>>>>\(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
