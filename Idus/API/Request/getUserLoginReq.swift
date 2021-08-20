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
                        print("DEBUG>> USER API GET Response \(result) ")
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
                    print("서버점검중입니다")
                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }
    
    
    func postUserJoin(_ loginViewController: LogInViewController, name: String, email : String, password: String, phone : String, term1 : Bool , term2 : Bool , term3 : Bool, recommendEmail : String) {

        let t1 = term1 == true ? "Y" : "N"
        let t2 = term2 == true ? "Y" : "N"
        let t3 = term3 == true ? "Y" : "N"
        
        let url = "http://dhlcutpdus.site:9000/users"

//        let params : [JoinRequest] = []

        
        if ( recommendEmail != ""){
            let params = [
                "name" : name,
                "email" : email,
                "password" : password,
                "phoneNumber" : phone,
                "term1" : t1,
                "term2" : t2,
                "term3" : t3,
                "recommendEmail" : recommendEmail
            ]
            
            AF.request(url,
                       method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder(),
                       headers: nil
            )
            .validate()
            .responseDecodable(of: GetUserJoinRes.self) { response in

                    switch response.result {
            
                    case .success(let response):
                        if response.isSuccess!, let result = response.result {
                            print("DEBUG>> USER API GET Response \(result) ")
                            loginViewController.didSuccessJoin(response)
                        }
                        // 실패했을 때 validation
                        else {
                            print(response)
                            switch response.code {
                                case 2015:
                                    loginViewController.didFailure("이메일을 입력해주세요")
                                case 2016:
                                    loginViewController.didFailure("이메일 형식을 확인해주세요")
                                case 2018:
                                    loginViewController.didFailure("비밀번호가 너무 짧습니다")
                                case 2019:
                                    loginViewController.didFailure("이름을 입력해주세요")
                                case 2020:
                                    loginViewController.didFailure("전화번호를 입력해주세요")
                                case 2022:
                                    loginViewController.didFailure("term 파라미터를 확인해주세요. 대문자 Y,혹은 N이어야 합니다.")
                                case 2203:
                                    loginViewController.didFailure("존재하지 않는 추천인입니다")
                                case 4000:
                                    loginViewController.didFailure("데이터베이스 연결에 실패하였습니")
                                default :
                                    loginViewController.didFailure("탈퇴한 유저입니다.")
                            }
                        }

                    case .failure(let error):
                        print("서버점검중입니다")
                        print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                    }
                }
            
        }else {
            let params = [
                "name" : name,
                "email" : email,
                "password" : password,
                "phoneNumber" : phone,
                "term1" : t1,
                "term2" : t2,
                "term3" : t3,
            ]
            AF.request(url,
                       method: .post,
                       parameters: params,
                       encoder: JSONParameterEncoder(),
                       headers: nil
            )
            .validate()
            .responseDecodable(of: GetUserJoinRes.self) { response in

                    switch response.result {
            
                    case .success(let response):
                        if response.isSuccess!, let result = response.result {
                            print("DEBUG>> USER API GET Response \(result) ")
                            print(result)
                            loginViewController.didSuccessJoin(response)

                        }
                        print(response)
                        switch response.code {
                            case 2015:
                                loginViewController.didFailure("이메일을 입력해주세요")
                            case 2016:
                                loginViewController.didFailure("이메일 형식을 확인해주세요")
                            case 2018:
                                loginViewController.didFailure("비밀번호가 너무 짧습니다")
                            case 2019:
                                loginViewController.didFailure("이름을 입력해주세요")
                            case 2020:
                                loginViewController.didFailure("전화번호를 입력해주세요")
                            case 2022:
                                loginViewController.didFailure("term 파라미터를 확인해주세요. 대문자 Y,혹은 N이어야 합니다.")
                            case 2203:
                                loginViewController.didFailure("존재하지 않는 추천인입니다")
                            case 4000:
                                loginViewController.didFailure("데이터베이스 연결에 실패하였습니")
                            default :
                                loginViewController.didFailure("탈퇴한 유저입니다.")
                        }

                    case .failure(let error):
                        print("서버점검중입니다")
                        print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                    }
                }
            
        }
        
      
    }

    
    
    
    
    
}
