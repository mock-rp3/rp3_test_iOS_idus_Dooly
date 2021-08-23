//
//  CategoryModel.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import Foundation

struct CategoryModel: Codable{
    var response: [Category]?
}

struct Category: Codable{
    var category: [CategoryDetails]?
}

struct CategoryDetails:Codable {
    var categoryWorkName : String?
    var categoryImage: String?
}

