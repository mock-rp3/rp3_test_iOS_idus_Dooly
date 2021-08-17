//
//  GetUserLoginRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation


struct GetUserLoginRes: Decodable{
    var isSuccess : Bool?
    var code : Int?
    var message : String?
    var result : UserData?

}


struct UserData: Decodable{
    var userIdx: Int?
    var jwt : String?
}
