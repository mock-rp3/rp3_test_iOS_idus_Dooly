//
//  GetUserLoginRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation


struct GetUserJoinRes: Decodable{
    var isSuccess : Bool?
    var code : Int?
    var message : String?
    var result : UserJoinData?
}

struct UserJoinData: Decodable{
    var jwt : String?
    var userIdx : Int?
    var recommendIdx : Int?
}
