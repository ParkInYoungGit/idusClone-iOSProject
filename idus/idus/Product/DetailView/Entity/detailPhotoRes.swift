//
//  detailPhotoRes.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import Foundation

struct detailPhotoRes : Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [PhotoResult]
}

// MARK: - Result
struct PhotoResult: Decodable {
    let num, photoIdx: Int
    let photoURL: String

    enum CodingKeys: String, CodingKey {
        case num, photoIdx
        case photoURL = "photoUrl"
    }
}
