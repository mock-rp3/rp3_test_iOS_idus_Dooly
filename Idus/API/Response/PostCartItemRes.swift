//
//  PostCartItemRes.swift
//  Idus
//
//  Created by 김희진 on 2021/08/27.
//
import Foundation


struct PostCartItemRes: Decodable{
    var isSuccess : Bool?
    var code : Int?
    var message : String?
    var result : Int?
}
