//
//  PostCartRequest.swift
//  Idus
//
//  Created by 김희진 on 2021/08/27.
//

import Foundation

struct PostCartRequest: Encodable {
    
    var itemIdx : String
    var userIdx : String
    var itemPrice : [ItemPrice]
    var delieveryPrice :  String?
}


struct ItemPrice: Encodable{
    var detailIdx : String?
    var IODIdx : String?
    var detail_name : String?
    var IOD_name : String?
    var price : String?
    var amount : String?
    var totalPrice : String?
}
