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
    
    
    func postItemOptions(_ PayDetailViewController: PayDetailViewController, userIdx: Int){
        
        
        let url = "http://dhlcutpdus.site:9000/buy"
        
        let params = PostItemRequest(itemIdx: 4, userIdx: userIdx, vip: "N", ask: "ddd", addressIdx: 1, totalPrice: 3800, delieveryPrice: 3000, detailIdx: [11], IODIdx: [6], buyDetailAmount: [1])
        
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
    
    
    
    func postCartOptions(_ itemDetailViewController: ItemDetailViewController, userIdx: Int){
        
        let url = "http://dhlcutpdus.site:9000/basket/add"

//        let params = PostCartRequest(itemIdx: 4, userIdx: 42, itemPrice: {detailIdx:"11",
//            IODIdx:"6",
//            detail_name:"옐로우",
//            IOD_name:"세척솔 1개(+1000원)",
//            price:"3800",
//            amount:"1",
//            totalPrice:"3800"}, delieveryPrice:"3000")

        let a = ItemPrice(detailIdx: "11", IODIdx: "6", detail_name: "옐로우", IOD_name: "세척솔 1개(+1000원)", price: "3800", amount: "1", totalPrice: "3800")

        let params = PostCartRequest(itemIdx: "4", userIdx: String(userIdx), itemPrice: [a], delieveryPrice: "3800")

        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil
        )
        .validate()
        .responseDecodable(of: PostCartItemRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    // 성공
                    if response.isSuccess!, let result = response.result {
                        print("DEBUG>> USER API GET Response \(result) ")
                        
                        itemDetailViewController.didCartSuccess(response)
                    }

                case .failure(let error):
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
        
    }
    
    
}
