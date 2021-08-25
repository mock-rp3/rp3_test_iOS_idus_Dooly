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
    var deleiverPrice : Int
    var intro : String?
    var imageAddress : [String]?
    var detail: [Detail]?
    var option_name : String?
    var option : [Option]
    var star : Float?
    var buy : Int?
    var reviewCount: Int?
    var review : [Review]?
    var writer: String?
    var writerImage : String?
}

struct Detail: Decodable{
    var detailIdx : Int?
    var title : String?
    var price : Int?
}

struct Option: Decodable{
    var title : String?
    var price : Int?
    var optionIdx : Int?
}

struct Review: Decodable{
    var reviewIdx : Int?
    var userIdx : Int?
    var userImage: String?
    var star : Int?
    var content : String?
    var imageUri : String?
    var detailIdx : Int?
    var buyContent : String?
    var iodidx : Int?
}
