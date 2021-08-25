//
//  Product.swift
//  Idus
//
//  Created by 김희진 on 2021/08/16.
//

import Foundation

struct ClassModel: Codable{
    var response: [Class]?
}

struct Class: Codable{
    var categoryName : String?
    var reviews: [Reviews]?
}

struct Reviews : Codable {
    var description : String?
    var star : String?
    var thumbReview : String?
    var thumbClass : String?
    var classDiscrip : String?
    var writer : String?
}

