//
//  GetUserLoginRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation


struct GetUserLoginRes: Decodable{
    var response: [Response]
}

struct Response: Decodable {
    var isSuccess : String?
    var code : String?
    var message : String?
    var result : UserData?
}

struct UserData: Decodable {
    var jwt : String?
    var userIdx: String?

}
