//
//  PatchUserInfoReq.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import Foundation
import Alamofire
import UIKit

class PatchUserInfoReq{
    
    func patchUserInfo(_ myInfoMyInfoViewController: MyInfoMyInfoViewController, token : String, userIdx: Int, key: String, value:String) {


        print(token, userIdx, key, value)
        
        let url = "http://dhlcutpdus.site:9000/users/edit/\(userIdx)"
        
        let params = [
            "name" : value
        ]

            
        let requestHeaders: HTTPHeaders = [
                "X-ACCESS-TOKEN": token,
                "Content-type": "application/json",
                "Accept": "application/json"
            ]


        AF.request(url,
                   method: .patch,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers : requestHeaders
        )
        .validate()
        .responseDecodable(of: GetUserInfoUpdateRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    // 성공
                    if response.isSuccess {
                        print("DEBUG>> USER API GET Response \(response) ")
                        myInfoMyInfoViewController.didSuccess(response)
                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        case 2001:
                                myInfoMyInfoViewController.didFailure("JWT를 입력해주세요")
                        case 2002:
                            myInfoMyInfoViewController.didFailure("유효하지 않은 JWT 입니다.")
                        case 2003:
                            myInfoMyInfoViewController.didFailure("권한이 없는 유저의 접근입니다.")
                        case 2016:
                            myInfoMyInfoViewController.didFailure("이메일 형식을 확인해주세요.")
                        case 2017:
                            myInfoMyInfoViewController.didFailure("중복된 이메일입니다.")
                        case 2018:
                            myInfoMyInfoViewController.didFailure("비밀번호가 너무 짧습니다.")
                        case 2207:
                            myInfoMyInfoViewController.didFailure("변동사항이 없습니다")

                        default :
                            myInfoMyInfoViewController.didFailure("변동사항이 없습니다")
                        }
                    }

                case .failure(let error):
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }
}
