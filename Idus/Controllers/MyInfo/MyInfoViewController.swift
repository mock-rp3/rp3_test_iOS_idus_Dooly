//
//  MyInfoViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//
import UIKit
import NaverThirdPartyLogin
import KakaoSDKAuth
import KakaoSDKUser

class MyInfoViewController: UIViewController {

    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    var userInfo : GetUserInfoRes? = nil
    
    @IBOutlet var MyInfoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false

//        GetMyInfo().getUserInfo(self, token: "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo0MSwiaWF0IjoxNjI5OTU0NDEzLCJleHAiOjE2MzE0MjU2NDJ9.x9-TUhf4L8khpXs-hi40PkqaYyG1UgnpXPfazFeglPo", userIdx : UserDefaults.standard.value(forKey: "userIdx"))
        
//        GetMyInfo().getUserInfo(self, token: UserDefaults.standard.value(forKey: "jwt") as! String, userIdx :  UserDefaults.standard.value(forKey: "userIdx")! as! Int)

        MyInfoTableView.dataSource = self
        MyInfoTableView.delegate = self
        self.navigationController?.navigationBar.isHidden = false
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let index = IndexPath(row: 0, section: 0)
        MyInfoTableView.reloadRows(at: [index], with: .automatic)
    }

}


extension MyInfoViewController {
    
    func didSuccess(_ response: GetUserInfoRes) {
        
        userInfo = response
    }
    
    func didFailure(_ message: String) {

        let alert = UIAlertController(title: "등록되지 않은 유저입니다", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}


extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return 4
        }
        else if (section == 1) {
            return 2
        }
        else if (section == 2) {
            return 1
        }
        else if (section == 3) {
            return 3
        }
        else if (section == 4) {
            return 1
        }
        else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0 ) {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoTableViewCell") as? MyInfoTableViewCell else {
                    return UITableViewCell()
                    
                }
                cell.username.text = (UserDefaults.standard.value(forKey: "name") as! String)
                cell.userPasswird.text = (UserDefaults.standard.value(forKey: "email") as! String)
                
                return cell
            }
            else if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell0") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
            if (indexPath.row == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell1") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell2") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                
                return cell
            }
            
        }
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell3") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
            if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell4") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
        }
        else if (indexPath.section == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell5") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
        }
        else if (indexPath.section == 3) {
            
            if (indexPath.row == 0) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell6") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
            if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell7") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if (indexPath.row == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell8") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
        }
        else if (indexPath.section == 4) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoDefualtTableViewCell9") as? MyInfoDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
        }
 
        else{
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0) {
            if(indexPath.row == 0 ){
                return tableView.frame.height * 0.23
            }else {
                return 60
            }
        }
        else {
            return 60
        }
 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if(indexPath.section == 4){
            
            
            let actionSheet = UIAlertController(title: nil , message: "로그아웃 하시겠습니까?", preferredStyle: .actionSheet)
            
            
            let agree = UIAlertAction(title: "예", style: .default ) { (action) in
                
                
                if UserDefaults.standard.value(forKey: "jwt") != nil{
                    
                    if((UserDefaults.standard.value(forKey: "platform") as! String) == "local") {
                        print("local User logout")
                    }
                    else if ((UserDefaults.standard.value(forKey: "platform") as! String) == "naver") {
                        self.loginInstance?.requestDeleteToken()
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
                    UserDefaults.standard.removeObject(forKey: "userIdx")
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

                    self.navigationController?.pushViewController(vc!, animated: true)

                }else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

                    self.navigationController?.pushViewController(vc!, animated: true)
                }
                
            }
            
            let cancel = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
            
            actionSheet.addAction(agree)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true, completion: nil)
            
        }
    }
    
}
