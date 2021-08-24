//
//  detailPhotoDataManager.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//
//

import Foundation

import Alamofire

class detailPhotoDataManager {
    func getProductDetailPhoto(productNum: Int, delegate: detailViewTableViewCell) {
        AF.request("\(Constant.BASE_URL)items/\(productNum)/photos", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseDecodable(of: detailPhotoRes.self) { response in
                print("photo result >>> \(response.result)")
                print("printdetail URL\(Constant.BASE_URL)\(productNum)")
                switch response.result {
                case .success(let response):
                    // 성공했을 때
                    if response.isSuccess
                    {
                    delegate.didSuccessProductDetailPhoto(data: response)
                        print("detailViewSuccess>>>>>>>>>>\(response.result)")
                        print("detailViewSuccess>>>>>>>>>>\(response.message)")
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 4000: delegate.failedToRequest2(message: "데이터베이스 연결에 실패했습니다.")
                        default: delegate.failedToRequest2(message: "피드백을 주세요")
                        }
                    }
                case .failure(let error):
                    print("detailViewFail>>>>>>>>>>>>>>\(error.localizedDescription)")
                    delegate.failedToRequest2(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
