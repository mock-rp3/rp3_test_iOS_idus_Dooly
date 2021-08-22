//
//  JoinRequest.swift
//  Idus
//
//  Created by 김희진 on 2021/08/20.
//

struct JoinRequest: Encodable {
    var name : String
    var email : String
    var password : String
    var phoneNumber : String
    var term1 : String
    var term2 : String
    var term3 : String
    var recommendEmail : String?
}

