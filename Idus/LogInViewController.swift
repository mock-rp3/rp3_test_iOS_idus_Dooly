//
//  LogInViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/16.
//

import Foundation
import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin
import Alamofire

class LogInViewController: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var localLogin: UIButton!
    @IBOutlet var naverLogin: UIButton!
    
    @IBOutlet var logInView: UIView!
    @IBOutlet var inputEmail: UITextField!
    @IBOutlet var inputPassword: UITextField!
    
    
    var timer = Timer()
    var backgroundArr = [UIImage(named: "login_image1"),UIImage(named: "login_image2"), UIImage(named: "login_image3"), UIImage(named: "login_image4"),UIImage(named: "login_image5"),UIImage(named: "login_image6"),UIImage(named: "login_image7"),UIImage(named: "login_image8") ]
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localLogin.layer.cornerRadius = 22.0
        naverLogin.layer.cornerRadius = 22.0


        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil ,  repeats: true)

    }
    
    @objc func changeImage() {
         
        if ( index + 1 == backgroundArr.count){
            index = 0
        }else {
            index += 1
        }
        backgroundImage.image = backgroundArr[index]

    }
    
    
    
    
    @IBAction func localLogIn(_ sender: Any) {
       
        logInView.isHidden = false
        
    }
    
    @IBAction func btnX(_ sender: Any) {
        logInView.isHidden = true
       
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
    }
    
    
    
    
    @IBAction func kakaoLogin(_ sender: Any) {
        
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")

                    //do something
                    _ = oauthToken
                }
            }
        
        
        // 기존 로그인 여부와 상관없이 로그인 요청 -> 일단 개발때는 만들어둔다
        UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")

                //do something
                _ = oauthToken

            }
        }
        
        
        // 토큰 존재여부 확인하기
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                }
            }
        }
        else {
            //로그인 필요
        }

        
        // 사용자 액세스 토큰 정보 조회
        UserApi.shared.accessTokenInfo {(accessTokenInfo, error) in
            if let error = error {
                print(error)
            }
            else {
                print("accessTokenInfo() success.")

                //do something
                _ = accessTokenInfo
            }
        }
        
        
        
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")

                _ = user
                print(user as Any)
                

//                UserDefaults.standard.set(user?.kakaoAccount?.profile?.nickname, forKey: "name")
//                UserDefaults.standard.set("010-9986-1675", forKey: "mobile")
//                UserDefaults.standard.set(img, forKey: "profile_image")
//                UserDefaults.standard.set("tktmzp0526@naver.com", forKey: "email")
//                UserDefaults.standard.set("F", forKey: "gender")

            }
        }
        
        
        // 추가항목 동의 받기
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                if let user = user {

                    //필요한 scope을 아래의 예제코드를 참고해서 추가한다.
                    //아래 예제는 모든 스콥을 나열한것.
                    var scopes = [String]()

                    if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
                    if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
                    if (user.kakaoAccount?.birthdayNeedsAgreement == true) { scopes.append("birthday") }
                    if (user.kakaoAccount?.birthyearNeedsAgreement == true) { scopes.append("birthyear") }
                    if (user.kakaoAccount?.genderNeedsAgreement == true) { scopes.append("gender") }
                    if (user.kakaoAccount?.phoneNumberNeedsAgreement == true) { scopes.append("phone_number") }
                    if (user.kakaoAccount?.ageRangeNeedsAgreement == true) { scopes.append("age_range") }
                    if (user.kakaoAccount?.ciNeedsAgreement == true) { scopes.append("account_ci") }

                    if scopes.count == 0  { return }

                    //필요한 scope으로 토큰갱신을 한다.
                    UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            UserApi.shared.me() { (user, error) in
                                if let error = error {
                                    print(error)
                                }
                                else {
                                    print("me() success.")

                                    _ = user
                                    print(user as Any)
//                                    self.oauthName.text = user?.kakaoAccount?.profile?.nickname
//                                    self.ouathPlatform.text = "login as Kakao"

                                    
//                                    let img = (user?.properties!["thumbnail_image"]!)!
//                                    UserDefaults.standard.set(user?.kakaoAccount?.profile?.nickname, forKey: "name")
//                                    UserDefaults.standard.set("010-9986-1675", forKey: "mobile")
//                                    UserDefaults.standard.set(img, forKey: "profile_image")
//                                    UserDefaults.standard.set("tktmzp0526@naver.com", forKey: "email")
//                                    UserDefaults.standard.set("F", forKey: "gender")
//
//                                    let url = URL(string : user?.kakaoAccount?.profile?.profileImageUrl); do {
//                                            let data = try Data(contentsOf: url!)
//                                        vc.test.image = UIImage(data: data)
//                                    } catch{
//
//                                    }
                                }

                            } //UserApi.shared.me()
                        }

                    } //UserApi.shared.loginWithKakaoAccount(scopes:)
                }
            }
        }
        
    }
    
}
