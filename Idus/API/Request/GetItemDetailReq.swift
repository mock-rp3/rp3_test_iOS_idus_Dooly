//
//  getUserLoginReq.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation
import Alamofire
import UIKit


class GetItemDetailReq {
    
    func getItemData(_ itemDetailViewController: ItemDetailViewController, itemIdx : Int) {

        let url = "http://dhlcutpdus.site:9000/item/info"

        let params = [
            "itemIdx" : itemIdx,
        ]

        AF.request(url,
                   method: .get,
                   parameters: params,
                   headers: nil
        )
        .responseDecodable(of: GetItemDetailRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    // 성공
                    if response.isSuccess! {
//                        print("DEBUG>> USER API GET Response \(result) ")
                        itemDetailViewController.didSuccess(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                            case 4000:
                                print("데이터베이스 연결에 실패하였습니다")
                            default :
                                print("!!")
                        }
                    }

                case .failure(let error):
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }
    
}
