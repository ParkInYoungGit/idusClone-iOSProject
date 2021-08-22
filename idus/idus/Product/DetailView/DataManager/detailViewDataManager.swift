//
//  detailViewDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import Foundation

import Alamofire

class detailViewDataManager {
    func getProductDetail(productNum: Int, delegate: detailViewController) {
        AF.request("\(Constant.BASE_URL)items/\(productNum)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: detailViewRes.self) { response in
                print("response result >>> \(response.result)")
                print("printdetail URL\(Constant.BASE_URL)\(productNum)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    delegate.didSuccessProductDetail(data: response)
                        print("detailViewSuccess>>>>>>>>>>\(response.result)")
                        print("detailViewSuccess>>>>>>>>>>\(response.message)")

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
                    print("detailViewFail>>>>>>>>>>>>>>\(error.localizedDescription)")
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
