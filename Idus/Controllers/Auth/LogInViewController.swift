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
    @IBOutlet var joinPageImage: UIImageView!
    
    @IBOutlet var localLogin: UIButton!
    @IBOutlet var naverLogin: UIButton!
    
    
    @IBOutlet var logInView: UIView!
    @IBOutlet var loginText: UILabel!
    @IBOutlet var btn1: UIButton!
    @IBOutlet var btn2: UIButton!
    @IBOutlet var btn3: UIButton!
    @IBOutlet var btn4: UIButton!
    @IBOutlet var btn5: UIButton!
    @IBOutlet var emailText: UILabel!
    @IBOutlet var inputEmail: UITextField!
    @IBOutlet var inputPassword: UITextField!
    @IBOutlet var btnSubmit: UIButton!
    @IBOutlet var alertText: UILabel!
    
    
    @IBOutlet var joinView: UIView!
    @IBOutlet var joinEmail: UITextField!
    @IBOutlet var joinName: UITextField!
    @IBOutlet var joinPassword: UITextField!
    @IBOutlet var joinPassword2: UITextField!
    @IBOutlet var joinPhone: UITextField!
    @IBOutlet var joinFriend: UITextField!
    @IBOutlet var btnJoin: UIButton!
    
    @IBOutlet var btnCheckAll: UIButton!
    @IBOutlet var btnCheck1: UIButton!
    @IBOutlet var btnCheck2: UIButton!
    @IBOutlet var btnCheck3: UIButton!
    var checkAll : Bool = false
    var check1 : Bool = false
    var check2 : Bool = false
    var check3 : Bool = false

    
    
    var UserData : GetUserLoginRes? = nil

    
    var timer = Timer()
    var backgroundArr = [UIImage(named: "login_image1"),UIImage(named: "login_image2"), UIImage(named: "login_image3"), UIImage(named: "login_image4"),UIImage(named: "login_image5"),UIImage(named: "login_image6"),UIImage(named: "login_image7"),UIImage(named: "login_image8") ]
    var index = 0
    
    let email = "1111"
    let password = "2222"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginInstance?.requestDeleteToken()

        localLogin.layer.cornerRadius = 22.0
        naverLogin.layer.cornerRadius = 22.0

        
        

        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(changeImage), userInfo: nil ,  repeats: true)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if UserDefaults.standard.value(forKey: "jwt") != nil {

            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarController")
            navigationController?.pushViewController(vc!, animated: true)

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
        
        logInView.isHidden = true
        
        btnCheckAll.tag = 1
        btnCheck1.tag = 10
        btnCheck2.tag = 20
        btnCheck3.tag = 30

        
        
        joinEmail.attributedPlaceholder = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        joinName.attributedPlaceholder = NSAttributedString(string: "이름", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        joinPassword.attributedPlaceholder = NSAttributedString(string: "비밀번호 ( 영문 + 숫자 + 특수문자 8자 이상", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        joinPassword2.attributedPlaceholder = NSAttributedString(string: "비밀번호 확인", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        joinPhone.attributedPlaceholder = NSAttributedString(string: "전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        joinFriend.attributedPlaceholder = NSAttributedString(string: "추천인코드 (선택사항)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])


        btnJoin.layer.cornerRadius = 22.0

        
        joinPageImage.image = UIImage(named: "join_background3")
        joinView.isHidden = false

    }
    
    
    @IBAction func localLogIn(_ sender: Any) {
        
        joinView.isHidden = true
        
        loginPageImage.image = UIImage(named: "join_background2")
        
        let text1 = "Apple 로그인 시 이용약관 및 "
        let text2 = "에 동의하는걸로 간주합니다"
        var attributedString = NSMutableAttributedString.init(string: "\(text1)개인정보 처리방침\(text2)")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: text1.count, length: 9))
        alertText.attributedText = attributedString
        
        
       attributedString = NSMutableAttributedString.init(string: "SNS 로그인")
       attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: 7))
//       attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.Carort!, range: NSRange.init(location: text.count, length: 4))
        loginText.attributedText = attributedString

        attributedString = NSMutableAttributedString.init(string: "이메일 로그인")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: 7))
         emailText.attributedText = attributedString

        
        btn1.layer.cornerRadius = 22.0
        btn2.layer.cornerRadius = 22.0
        btn3.layer.cornerRadius = 22.0
        btn4.layer.cornerRadius = 22.0
        btn5.layer.cornerRadius = 22.0
        btnSubmit.layer.cornerRadius = 17.0

        
        logInView.isHidden = false

        
    }
    
    @IBAction func btnX(_ sender: Any) {
        logInView.isHidden = true
        joinView.isHidden = true
       
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        if inputEmail.text == "" {
            let alert = UIAlertController(title: "이메일을 입력하세요", message: "이메일을 입력하세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        else if inputPassword.text == "" {
            let alert = UIAlertController(title: "비밀번호를 입력하세요", message: "비밀번호를 입력하세요", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)

        }else {
            GetUserLoginReq().getUserData(self, email: inputEmail.text!, password: inputPassword.text!)
        }
    }
    
    
    @IBAction func checkAllBtn(_ sender: UIButton) {
        
        if(sender.tag == 1){
            checkAll = !checkAll
            
            if (checkAll == true ) {
                btnCheckAll.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                btnCheck1.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                btnCheck2.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                btnCheck3.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                check1 = true
                check2 = true
                check3 = true
            } else {
                btnCheckAll.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                btnCheck1.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                btnCheck2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                btnCheck3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                check1 = false
                check2 = false
                check3 = false
            }
        }
        else {
            if(sender.tag == 10) {
                check1 = !check1
                if(check1 == true){
                    btnCheck1.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                }else{
                    btnCheck1.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                }
            }else if(sender.tag == 20) {
                check2 = !check2
                if(check2 == true){
                    btnCheck2.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                } else{
                    btnCheck2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                }
            } else {
                check3 = !check3
                if(check3 == true){
                    btnCheck3.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                }else{
                    btnCheck3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
                }
            }
            
            if (check1 && check2 && check3) {
                checkAll = true
                btnCheckAll.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            }
            else  {
                checkAll = false
                btnCheckAll.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            }
        }
    }
    
    
    @IBAction func btnJoinSubmit(_ sender: Any) {
        //joinPassword != joinPassword2
        //각 값이 안들어가있을때 입력 알람창 띄우기
        print(joinEmail.text!)
        print(joinName.text!)
        print(joinPassword.text!)
        print(joinPassword2.text!)
        print(joinPhone.text!)
        print(joinFriend.text!)
        print(check1, check2, check3)

        

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

        let userJwt = response.result?.jwt
                
        logInView.isHidden = true

        UserDefaults.standard.set(inputEmail.text, forKey: "email")
        UserDefaults.standard.set(inputPassword.text, forKey: "password")
        UserDefaults.standard.set("김희진", forKey: "name")
        UserDefaults.standard.set("local", forKey: "platform")
        UserDefaults.standard.set(userJwt, forKey: "jwt")

        
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarController")
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func didFailure(_ message: String) {
        
        let alert = UIAlertController(title: "alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
                     
    }
}
