//
//  PostBuyItemRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/23.
//

import Foundation


struct PostBuyItemRes: Decodable{
    var isSuccess : Bool?
    var code : Int?
    var message : String?
    var result : String?
}
