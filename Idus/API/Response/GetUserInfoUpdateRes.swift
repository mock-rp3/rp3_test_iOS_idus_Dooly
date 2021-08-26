//
//  GetUserInfoUpdateRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import Foundation


import Foundation


struct GetUserInfoUpdateRes: Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : Int
}
