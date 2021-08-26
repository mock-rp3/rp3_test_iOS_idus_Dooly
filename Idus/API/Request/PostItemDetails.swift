//
//  PostItemDetails.swift
//  Idus
//
//  Created by 김희진 on 2021/08/23.
//

import Foundation
import Alamofire
import UIKit


class PostItemDetails{
    
    
    func postItemOptions(_ PayDetailViewController: PayDetailViewController ){
        
        
        let url = "http://dhlcutpdus.site:9000/buy"

//        let params:PostItemRequest = {
//            "itemIdx" : 1,
//            "userIdx" : 11,
//            "vip" : "Y",
//            "ask" : "ddd",
//            "addressIdx" : 1,
//            "totalPrice" : 4000,
//            "delieveryPrice" : 0,
//            "detailIdx" : [2],
//            "IODIdx" : [2],
//            "buyDetailAmount" : [1]
//        }
        
//        {
//            "itemIdx":"4",
//            "userIdx":"11",
//            "vip":"N",
//            "ask":"ddd",
//            "addressIdx":"1",
//            "totalPrice":"3800",
//            "delieveryPrice":"3000",
//            "detailIdx":[11],
//            "IODIdx":[6],
//            "buyDetailAmount":[1]
//        }
        
        let params = PostItemRequest(itemIdx: 4, userIdx: 11, vip: "N", ask: "ddd", addressIdx: 1, totalPrice: 3800, delieveryPrice: 3000, detailIdx: [11], IODIdx: [6], buyDetailAmount: [1])
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil
        )
        .validate()
        .responseDecodable(of: PostBuyItemRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    // 성공
                    if response.isSuccess!, let result = response.result {
                        print("DEBUG>> USER API GET Response \(result) ")
                        
                        PayDetailViewController.didBuySuccess(response)
                    }

                case .failure(let error):
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
        
    }
    
}
