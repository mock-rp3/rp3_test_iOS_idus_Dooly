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

class LogInViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {

    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var loginPageImage: UIImageView!
    
    @IBOutlet var localLogin: UIButton!
    @IBOutlet var naverLogin: UIButton!
    
    
    @IBOutlet var logInView: UIView!
    @IBOutlet var inputEmail: UITextField!
    @IBOutlet var inputPassword: UITextField!
    
    @IBOutlet var joinEmail: UITextField!
    @IBOutlet var joinName: UITextField!
    @IBOutlet var joinPassword: UITextField!
    @IBOutlet var joinPassword2: UITextField!
    @IBOutlet var joinPhone: UITextField!
    
    var UserData : GetUserLoginRes? = nil

    
    var timer = Timer()
    var backgroundArr = [UIImage(named: "login_image1"),UIImage(named: "login_image2"), UIImage(named: "login_image3"), UIImage(named: "login_image4"),UIImage(named: "login_image5"),UIImage(named: "login_image6"),UIImage(named: "login_image7"),UIImage(named: "login_image8") ]
    var index = 0
    
    let email = "1111"
    let password = "2222"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        checkUser()
        loginInstance?.requestDeleteToken()

        localLogin.layer.cornerRadius = 22.0
        naverLogin.layer.cornerRadius = 22.0


        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil ,  repeats: true)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if UserDefaults.standard.value(forKey: "email") != nil {

            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
            navigationController?.pushViewController(vc!, animated: true)

            
            
//            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
//
//            window?.rootViewController = vc

        }

    }
    
    
    
    @objc func changeImage() {
         
        if ( index + 1 == backgroundArr.count){
            index = 0
        }else {
            index += 1
        }
        backgroundImage.image = backgroundArr[index]

    }
    
    
    
    
    @IBAction func localJoin(_ sender: Any) {
        joinEmail.isHidden = false
        joinName.isHidden = false
        joinPassword.isHidden = false
        joinPassword2.isHidden = false
        joinPhone.isHidden = false

        inputEmail.isHidden = true
        inputPassword.isHidden = true
        loginPageImage.image = UIImage(named: "joinPageImage")
        logInView.isHidden = false

    }
    
    
    @IBAction func localLogIn(_ sender: Any) {
        
        joinEmail.isHidden = true
        joinName.isHidden = true
        joinPassword.isHidden = true
        joinPassword2.isHidden = true
        joinPhone.isHidden = true
        
        inputEmail.isHidden = false
        inputPassword.isHidden = false


        loginPageImage.image = UIImage(named: "logInPageImage")
        logInView.isHidden = false
        
    }
    
    @IBAction func btnX(_ sender: Any) {
        logInView.isHidden = true
       
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
//        GetUserLoginReq().getUserData(self, email: email, password: password)
 
        
        // api 통신 후 서버가 로그인 성공하면 유저 데이터를 쏴줄거임 ! 그걸 저장해야해 ( JWT 포함 )
        // if 문에 서버의 isSuceess 가 true 일때라고 해줘야함
        if email == inputEmail.text! && password == inputPassword.text! {

            logInView.isHidden = true

            //서버가 주는 값들을 저장해야해
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set("김희진", forKey: "name")
            UserDefaults.standard.set("local", forKey: "platform")


            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
            navigationController?.pushViewController(vc, animated: true)

        }else{
            let alert = UIAlertController(title: "alert", message: "없는 회원입니다", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    
    @IBAction func noLogin(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func naverLogin(_ sender: Any) {
        loginInstance?.delegate = self

        loginInstance?.requestThirdPartyLogin()

    }
    
    
    // 로그인에 성공한 경우 호출
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getInfo()
    }
    
    // referesh token
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    // 로그아웃
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    // 모든 error
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }
    
    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let id = object["id"] as? String else {return}
        guard let mobile = object["mobile"] as? String else {return}
        guard let profile_image = object["profile_image"] as? String else {return}
        guard let gender = object["gender"] as? String else {return}

         print(result)
         
         UserDefaults.standard.set(name, forKey: "name")
         UserDefaults.standard.set(mobile, forKey: "mobile")
         UserDefaults.standard.set(profile_image, forKey: "profile_image")
         UserDefaults.standard.set(email, forKey: "email")
         UserDefaults.standard.set(gender, forKey: "gender")

         
        print(id,name,email)
         
      }
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


extension LogInViewController {
    
    func didSuccess(_ response: GetUserLoginRes) {
        
        UserData = response
        
        print(UserData as Any)
        
        // api 통신 후 서버가 로그인 성공하면 유저 데이터를 쏴줄거임 ! 그걸 저장해야해 ( JWT 포함 )
        // if 문에 서버의 isSuceess 가 true 일때라고 해줘야함
        if email == inputEmail.text! && password == inputPassword.text! {
            
            logInView.isHidden = true

            //서버가 주는 값들을 저장해야해
            UserDefaults.standard.set(email, forKey: "email")
            UserDefaults.standard.set(password, forKey: "password")
            UserDefaults.standard.set("김희진", forKey: "name")
            UserDefaults.standard.set("local", forKey: "platform")

            
            let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
            navigationController?.pushViewController(vc, animated: true)

            
        }else{
            let alert = UIAlertController(title: "alert", message: "없는 회원입니다", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
                     
    }
}
