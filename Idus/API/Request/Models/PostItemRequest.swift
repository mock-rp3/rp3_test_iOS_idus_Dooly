//
//  PostItemRequest.swift
//  Idus
//
//  Created by 김희진 on 2021/08/23.
//

import Foundation

struct PostItemRequest: Encodable {
    
    var itemIdx : Int
    var userIdx : Int
    var vip : String
    var ask : String
    var addressIdx : Int
    var totalPrice : Int
    var delieveryPrice : Int
    var detailIdx : [Int]
    var IODIdx : [Int]
    var buyDetailAmount : [Int]
}
