//
//  GetMyInfo.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

//
//  getUserLoginReq.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation
import Alamofire
import UIKit


class GetMyInfo {
    
    func getUserInfo(_ myPageViewController: MyPageViewController, token : String, userIdx : Int) {

        let url = "http://dhlcutpdus.site:9000/users/info/\(userIdx)"

        let requestHeaders: HTTPHeaders = [
                "X-ACCESS-TOKEN": token,
                "Content-type": "application/x-www-form-urlencoded"
            ]
                
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers : requestHeaders
        )
        .responseDecodable(of: GetUserInfoRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    if response.isSuccess {
                        print("DEBUG>> USER API GET Response \(response) ")
                        myPageViewController.didSuccess(response)
                    }
                    else {
                        switch response.code {
                            case 2001:
                                print("JWT를 입력해주세요.")
                            case 2002:
                                print("유효하지 않은 JWT 입니다.")
                            case 4000:
                                print("데이터베이스 연결에 실패하였습니다")
                            default :
                                print("internal server error")
                        }
                    }

                case .failure(let error):
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }
    
    
    func getUserInfoReload(_ myInfoMyInfoViewController: MyInfoMyInfoViewController, token : String, userIdx : Int) {

        let url = "http://dhlcutpdus.site:9000/users/info/\(userIdx)"

        let requestHeaders: HTTPHeaders = [
                "X-ACCESS-TOKEN": token,
                "Content-type": "application/x-www-form-urlencoded"
            ]
                
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers : requestHeaders
        )
        .responseDecodable(of: GetUserInfoRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    if response.isSuccess {
                        print("DEBUG>> USER API GET Response \(response) ")
                        myInfoMyInfoViewController.didSuccessUpdate(response)
                    }
                    else {
                        switch response.code {
                            case 2001:
                                print("JWT를 입력해주세요.")
                            case 2002:
                                print("유효하지 않은 JWT 입니다.")
                            case 4000:
                                print("데이터베이스 연결에 실패하였습니다")
                            default :
                                print("internal server error")
                        }
                    }

                case .failure(let error):
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }
    
}
