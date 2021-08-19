//
//  GetItemDetailRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/19.
//

//

import Foundation


struct GetItemDetailRes: Decodable{
    var isSuccess : Bool?
    var code : Int?
    var message : String?
    var result : ItemData?

}


struct ItemData: Decodable{
    var itemIdx: Int
    var title : String
    var oriPrice : Int
    var discount : Int
    var finalPrice : Int
    var deleiverPrice : Int?
    var intro : String?
    var imageAddress : [String]?
}

