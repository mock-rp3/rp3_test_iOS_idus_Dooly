//
//  getUserLoginReq.swift
//  Idus
//
//  Created by 김희진 on 2021/08/17.
//

import Foundation
import Alamofire
import UIKit


class GetUserLoginReq {
    
    
    func getUserData(_ loginViewController: LogInViewController, email : String, password: String) {

        let url = "http://dhlcutpdus.site:9000/users/login"


        let params = [
            "email" : email,
            "password" : password
        ]

        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder(),
                   headers: nil
        )
        .validate()
        .responseDecodable(of: GetUserLoginRes.self) { response in

                switch response.result {
        
                case .success(let response):
                    // 성공
                    if response.isSuccess!, let result = response.result {
                        
                        print("DEBUG>> USER API GET Response \(response) ")
                        
                        loginViewController.didSuccess(response)

                    }
                    // 실패했을 때
                    else {
                        switch response.code {
                        
                            case 2022:
                                loginViewController.didFailure("탈퇴한 유저입니다.")
                            case 2023:
                                loginViewController.didFailure("정지된 유저입니다.")
                            case 2024:
                                loginViewController.didFailure("이메일을 입력해주세요.")
                            case 2025:
                                loginViewController.didFailure("비밀번호를 입력해주세요")
                            case 4012:
                                loginViewController.didFailure("비밀번호 복호화에 실패하였습니다")
                            case 3014:
                                loginViewController.didFailure("없는 아이디거나 비밀번호가 틀렸습니다")
                            case 2021:
                                loginViewController.didFailure("비밀번호를 입력해주세요")
                            case 4000:
                                loginViewController.didFailure("데이터베이스 연결에 실패하였습니")

                            default :
                                loginViewController.didFailure("탈퇴한 유저입니다.")

                        }
                    }

                case .failure(let error):
                    print("!!!!!!!!!")

                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }


    
    
    
    
}
