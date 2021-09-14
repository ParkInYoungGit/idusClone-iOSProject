//
//  orderDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import Foundation
import Alamofire

class orderDataManager {
    func postOrder(_ parameters: orderReq, delegate: buyViewController) {
        let header: HTTPHeaders = [
            "x-access-token" : Constant.shared.jwt]
        let userIdx = Constant.shared.idx
        AF.request("\(Constant.BASE_URL)items/5/order", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: header)
            .validate()
            .responseDecodable(of: orderRes.self) { response in
                print("response result >>> \(response.result)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess{
                        delegate.didSuccessOrder(response)
                        print("\(response.message)")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2010: delegate.failedToOrder(message: "유저 아이디 값을 확인해주세요.")
                        case 2011: delegate.failedToOrder(message: "유저 비밀번호 값을 확인해주세요.")
                        case 2015: delegate.failedToOrder(message: "이메일을 입력해주세요.")
                        case 2016: delegate.failedToOrder(message: "이메일 형식을 확인해주세요")
                        case 2017: delegate.failedToOrder(message: "중복된 이메일 입니다.")
                        case 2018: delegate.failedToOrder(message: "중복된 전화번호 입니다.")
                        case 2020: delegate.failedToOrder(message: "비밀번호 형식을 확인해주세요 (영문+숫자+특수문자 8자이상)")
                        default: delegate.failedToOrder(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToOrder(message: "서버와의 연결이 원활하지 않습니다")
                    //print("email찍어보기\(parameters.email)")
                }
            }
    }
}
