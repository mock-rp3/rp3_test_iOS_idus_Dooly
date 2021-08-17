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

        let url = "https://dhlcutpdus.site:9000/users/login"


        let params: Parameters = [
            "email" : email,
            "password" : password
        ]

       
        let header: HTTPHeaders = [ "Content-Type" : "application/json" ]

        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   headers: header
//                   encoding: URLEncoding.httpBody
        )
            .responseDecodable(of: GetUserLoginRes.self) { response in

                switch response.result {
                

                case .success(let response):
//                    print("DEBUG>> USER API GET Response \(response) ")
                    print("!!!!!!!!!")

                    loginViewController.didSuccess(response)

                case .failure(let error):
                    print("!!!!!!!!!")

                    print("DEBUG>> USER API Get Error : \(error.localizedDescription)")

                }
            }
    }


    
    
    
    
}
