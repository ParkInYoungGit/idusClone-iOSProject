//
//  loginDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import Foundation
import Alamofire

class LoginDataManager {
    func postLogIn(_ parameters: LoginReq, delegate: loginViewController) {
        AF.request("\(Constant.BASE_URL)users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: LoginRes.self) { response in
                print("response result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessLogIn(result)
                        print("\(response.message)")
                        Constant.shared.idx = response.result!.userIdx
                        Constant.shared.jwt = response.result!.jwt
                        
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2000: delegate.failedToLogin(message: "상황에 맞는")
                        case 3000: delegate.failedToLogin(message: "에러 메시지로")
                        case 4000: delegate.failedToLogin(message: "사용자에게 적절한")
                        default: delegate.failedToLogin(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToLogin(message: "서버와의 연결이 원활하지 않습니다")
                    print("email찍어보기\(parameters.email)")
                }
            }
    }
}
