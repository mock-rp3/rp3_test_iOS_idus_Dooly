//
//  Product.swift
//  Idus
//
//  Created by 김희진 on 2021/08/16.
//

import Foundation

struct ProductModel: Codable{
    var response: [Product]?
}

struct Product: Codable{
    var categoryName : String?
    var products: [ProductDetails]?
}

struct ProductDetails : Codable {
    var name : String?
    var imageName : String?
    var price : String?
    var description : String?
    var star : String?
    var thumbReview : String?
    var reviewCount : String?
}

