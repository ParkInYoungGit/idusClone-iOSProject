//
//  orderReq.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import Foundation

struct orderReq: Encodable {
    let userIdx, addressIdx, price, purchaseQuantity: Int
     let itemOpt1Idx: Int
 }
