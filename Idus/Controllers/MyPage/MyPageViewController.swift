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
   
    @IBOutlet var mypageTableView: UITableView!
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()

    var userInfo : GetUserInfoRes? = nil


    @IBOutlet var platform: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var password: UILabel!
    @IBOutlet var topView: UIView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        if UserDefaults.standard.value(forKey: "jwt") != nil{
            if (UserDefaults.standard.value(forKey: "platform") as! String == "local"){
                GetMyInfo().getUserInfo(self, token: UserDefaults.standard.value(forKey: "jwt") as! String, userIdx :  UserDefaults.standard.value(forKey: "userIdx")! as! Int)

            }
        }
        
        
        let MyPageTableViewCell = UINib(nibName: "MyPageTableViewCell", bundle: nil)
        self.mypageTableView.register(MyPageTableViewCell, forCellReuseIdentifier: "MyPageTableViewCell")

        let MyPageNoUserTableViewCell = UINib(nibName: "MyPageNoUserTableViewCell", bundle: nil)
        self.mypageTableView.register(MyPageNoUserTableViewCell, forCellReuseIdentifier: "MyPageNoUserTableViewCell")


        mypageTableView.dataSource = self
        mypageTableView.delegate = self

//        if UserDefaults.standard.value(forKey: "email") != nil  && UserDefaults.standard.value(forKey: "password") != nil {
//            email.text = (UserDefaults.standard.value(forKey: "email") as! String)
//            password.text = (UserDefaults.standard.value(forKey: "password") as! String)
//            platform.text = (UserDefaults.standard.value(forKey: "platform") as! String)
//            print((UserDefaults.standard.value(forKey: "jwt") as! String))
//
//        }else {
//            button.setTitle("로그인하러가기", for: .normal)
//        }
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        mypageTableView.tableFooterView = footer
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let index = IndexPath(row: 0, section: 0)
        mypageTableView.reloadRows(at: [index], with: .automatic)
        mypageTableView.reloadData()
        self.navigationController?.navigationBar.isHidden = true

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
            UserDefaults.standard.removeObject(forKey: "userIdx")
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

            navigationController?.pushViewController(vc!, animated: true)

        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}



extension MyPageViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (section == 0) {
            return 1
        }
        else if (section == 2) {
            return 1
        }
        else {
            return 4
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            
            if UserDefaults.standard.value(forKey: "jwt") != nil{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageTableViewCell", for: indexPath) as? MyPageTableViewCell else { return UITableViewCell()}
                
                cell.cellDelegate2 = self
                cell.userName.text = UserDefaults.standard.value(forKey: "name") as? String
                return cell

            }
            else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageNoUserTableViewCell", for: indexPath) as? MyPageNoUserTableViewCell else { return UITableViewCell()}
                                
                cell.cellDelegate = self
                return cell
            }
            
        }
        else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section_1_0_MyPageTableViewCell") as? MyPageDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
            if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section_1_1_MyPageTableViewCell") as? MyPageDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }

            if (indexPath.row == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section_1_2_MyPageTableViewCell") as? MyPageDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }

            if (indexPath.row == 3) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "Section_1_3_MyPageTableViewCell") as? MyPageDefualtTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }

        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageAdTableViewCell", for: indexPath) as? MyPageAdTableViewCell else { return UITableViewCell()}
                        
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0) {
        
            if UserDefaults.standard.value(forKey: "jwt") != nil{
                
                return tableView.frame.height * 0.38

            }
            else {
                return tableView.frame.height * 0.5
            }
        
        }
        
        else if (indexPath.section == 2) {
            return tableView.frame.height * 0.1
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
    
        if(indexPath.section == 1){
            if(indexPath.row == 1){
                print("!!")
            }
        }
        
    }
    
}


extension MyPageViewController: MyCellDelegate{
    
    func clickLogin() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

        navigationController?.pushViewController(vc!, animated: true)

    }
}

extension MyPageViewController: GoDelegate{
    
    func clickUserInfo() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyInfoViewController") as? MyInfoViewController

        navigationController?.pushViewController(vc!, animated: true)

    }

}


extension MyPageViewController {
    
    func didSuccess(_ response: GetUserInfoRes) {
        
        userInfo = response

        UserDefaults.standard.set(response.result?.name , forKey: "name")
        UserDefaults.standard.set(response.result?.email , forKey: "email")
        UserDefaults.standard.set(response.result?.phoneNumber , forKey: "phoneNumber")
        UserDefaults.standard.set(response.result?.birth , forKey: "birth")
        UserDefaults.standard.set(response.result?.rank , forKey: "rank")
        UserDefaults.standard.set(response.result?.gender , forKey: "gender")
 
        mypageTableView.reloadData()

    }
    
    func didFailure(_ message: String) {

        let alert = UIAlertController(title: "등록되지 않은 유저입니다", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

}
