//
//  mypageDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/18.
//

import Foundation
import Alamofire
//var userIdx = 5

class MyPageDataManager {
 
    func getMyPage(_ parameters: Int, delegate: MyPageViewController) {
        
        let header: HTTPHeaders = [
            "x-access-token" : Constant.shared.jwt]

        AF.request("\(Constant.BASE_URL)users/info/\(parameters)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            .validate()
            .responseDecodable(of: myPageRes.self) { response in
                print("responsemypage result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessMypage(result)
                        print("\(response.message)")
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000: delegate.failedToRequest(message: "상황에 맞는")
                        case 3000: delegate.failedToRequest(message: "에러 메시지로")
                        case 4000: delegate.failedToRequest(message: "로그인이 필요합니다.")
                            
                        default: delegate.failedToRequest(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
