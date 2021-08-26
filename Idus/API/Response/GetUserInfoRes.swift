//
//  GetItemDetailRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/19.
//

//

import Foundation


struct GetUserInfoRes: Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : UserInfo?

}


struct UserInfo: Decodable{
    var name: String
    var email : String
    var phoneNumber : String
    var birth : Int?
    var rank : String
    var gender : Int?
}
