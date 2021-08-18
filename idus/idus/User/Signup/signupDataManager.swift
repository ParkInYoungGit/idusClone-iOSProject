//
//  signupDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import Foundation
import Alamofire

class SignupDataManager {
    func postSignUp(_ parameters: SignupReq, delegate: signupViewController) {
        AF.request("\(Constant.BASE_URL)users/sign-up", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: nil)
            .validate()
            .responseDecodable(of: SignUpRes.self) { response in
                print("response result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess, let result = response.result {
                        delegate.didSuccessSignUp(result)
                        print("\(response.message)")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2010: delegate.failedToRequest(message: "유저 아이디 값을 확인해주세요.")
                        case 2011: delegate.failedToRequest(message: "유저 비밀번호 값을 확인해주세요.")
                        case 2015: delegate.failedToRequest(message: "이메일을 입력해주세요.")
                        case 2016: delegate.failedToRequest(message: "이메일 형식을 확인해주세요")
                        case 2017: delegate.failedToRequest(message: "중복된 이메일 입니다.")
                        case 2018: delegate.failedToRequest(message: "중복된 전화번호 입니다.")
                        case 2020: delegate.failedToRequest(message: "비밀번호 형식을 확인해주세요 (영문+숫자+특수문자 8자이상)")
                        default: delegate.failedToRequest(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                    print("email찍어보기\(parameters.email)")
                }
            }
    }
}
