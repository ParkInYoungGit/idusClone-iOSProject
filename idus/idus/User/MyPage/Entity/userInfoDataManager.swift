//
//  userInfoDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//
import Alamofire
import Foundation
class userInfoDataManager {
    
    func registrationUserInfo(delegate: userInfoTableViewController ) {
//        let header: HTTPHeaders = [
//            "x-access-token" : "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo0LCJpYXQiOjE2Mjk5NDQyOTYsImV4cCI6MTYzMTQxNTUyNX0.vIClVN0soce2nq34L6OpDHHIpVT_4lK8drRsnNzwvjc"
//        ]
//
        
        let header: HTTPHeaders = [
            "x-access-token" : Constant.shared.jwt]
  
        // GET
        AF.request("\(Constant.BASE_URL)users/orders?userIdx=4", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: userInfoRes.self) { response in
                print("response result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess {
                        delegate.didSuccessUserInfo(response)
                        print("\(response.message)")
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000: delegate.failedTouserInfoRequest(message: "상황에 맞는")
                        case 3000: delegate.failedTouserInfoRequest(message: "에러 메시지로")
                        case 4000: delegate.failedTouserInfoRequest(message: "로그인이 필요합니다.")
                            
                        default: delegate.failedTouserInfoRequest(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedTouserInfoRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
