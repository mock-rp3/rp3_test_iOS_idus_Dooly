//
//  SignInRequest.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation

struct SignInRequest: Encodable {
    var email : String
    var password: String
}
