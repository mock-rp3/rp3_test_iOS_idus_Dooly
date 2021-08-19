//
//  MyPageViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKUser

class MyPageViewController: UIViewController {
   
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()


    @IBOutlet var platform: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var password: UILabel!
    
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  print(UserDefaults.standard.value(forKey: "name") as! String)

        if UserDefaults.standard.value(forKey: "email") != nil  && UserDefaults.standard.value(forKey: "password") != nil {
            email.text = (UserDefaults.standard.value(forKey: "email") as! String)
            name.text = (UserDefaults.standard.value(forKey: "name") as! String)
            password.text = (UserDefaults.standard.value(forKey: "password") as! String)
            platform.text = (UserDefaults.standard.value(forKey: "platform") as! String)
            print((UserDefaults.standard.value(forKey: "jwt") as! String))
           
        }else {
            button.setTitle("로그인하러가기", for: .normal)
        }

    }
    
    
    @IBAction func btnLogout(_ sender: Any) {        
        
        if UserDefaults.standard.value(forKey: "jwt") != nil{
            
            if((UserDefaults.standard.value(forKey: "platform") as! String) == "local") {
                print("local User logout")
            }
            else if ((UserDefaults.standard.value(forKey: "platform") as! String) == "naver") {
                loginInstance?.requestDeleteToken()
                print("Naver User log out")
            }
            else if ((UserDefaults.standard.value(forKey: "platform") as! String) == "kakao") {
                //로그아웃
                UserApi.shared.logout {(error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("logout() success.")
                    }
                }
                //연결해제
                // UserApi.shared.unlink {(error) in
                // if let error = error {
                //     print(error)
                // }
                // else {
                //   print("unlink() success.")
                // }
                // }
                
                print("Kakao User log out")

            }
            
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "password")
            UserDefaults.standard.removeObject(forKey: "name")
            UserDefaults.standard.removeObject(forKey: "platform")
            UserDefaults.standard.removeObject(forKey: "jwt")
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

            navigationController?.pushViewController(vc!, animated: true)

            
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

            navigationController?.pushViewController(vc!, animated: true)

            
        }
        

    }
    

}
