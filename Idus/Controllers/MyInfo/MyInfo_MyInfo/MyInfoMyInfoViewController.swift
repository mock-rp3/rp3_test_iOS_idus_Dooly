//
//  MyInfoMyInfoViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

class MyInfoMyInfoViewController: UIViewController {
    
    @IBOutlet var changeInfoTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeInfoTableView.delegate = self
        changeInfoTableView.dataSource = self
        self.navigationController?.navigationBar.isHidden = false

    }

}



extension MyInfoMyInfoViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0 ) {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell0") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.name.text = UserDefaults.standard.value(forKey: "name") as? String

              

                return cell
            }
            if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell1") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                if UserDefaults.standard.value(forKey: "phoneNumber") != nil{
                    cell.phoneNumber?.text = UserDefaults.standard.value(forKey: "phoneNumber") as? String
                }

                return cell
            }
            
            if (indexPath.row == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell2") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                cell.email.text = UserDefaults.standard.value(forKey: "email") as? String
                return cell
            }
          
        }
        else if (indexPath.section == 1) {
            
            if (indexPath.row == 0 ) {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell3") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell4") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
            if (indexPath.row == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell5") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
          
        }
            return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "주문, 배송시 등록된 번호로 SMS를 발송해 드립니다"
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.darkGray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if(indexPath.section == 0){
            if(indexPath.row == 0) {
                
                let alert = UIAlertController(title: "이름 변경", message: "이름(닉네임)을 입력하세요.", preferredStyle: .alert)

                alert.addTextField { (myTextField) in

                        myTextField.placeholder = UserDefaults.standard.value(forKey: "name") as? String
               }

                
                let ok = UIAlertAction(title: "확인", style: .default) { (ok) in

//                    print(alert.textFields?[0].text as Any)
                    
                    //patch 시작
                    //jwt, index, name이라는 키, 변경하는 값
                    PatchUserInfoReq().patchUserInfo(self, token : UserDefaults.standard.value(forKey: "jwt") as! String, userIdx: UserDefaults.standard.value(forKey: "userIdx")! as! Int, key : "name", value: (alert.textFields?[0].text)! )

                }

                let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

                alert.addAction(cancel)

                alert.addAction(ok)

                self.present(alert, animated: true, completion: nil)
               
            }
        }
    }
}



extension MyInfoMyInfoViewController {
    
    func didSuccess(_ response: GetUserInfoUpdateRes) {
        
        
        GetMyInfo().getUserInfoReload(self, token: UserDefaults.standard.value(forKey: "jwt") as! String, userIdx :  UserDefaults.standard.value(forKey: "userIdx")! as! Int)
    }
    
    func didFailure(_ message: String) {
        
        let alert = UIAlertController(title: "alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
        
        func didSuccessUpdate(_ response: GetUserInfoRes) {
            

            UserDefaults.standard.set(response.result?.name , forKey: "name")
            UserDefaults.standard.set(response.result?.email , forKey: "email")
            UserDefaults.standard.set(response.result?.phoneNumber , forKey: "phoneNumber")
            UserDefaults.standard.set(response.result?.birth , forKey: "birth")
            UserDefaults.standard.set(response.result?.rank , forKey: "rank")
            UserDefaults.standard.set(response.result?.gender , forKey: "gender")
            
            
            
            changeInfoTableView.reloadData()
                        
            let alert = UIAlertController(title: "", message: "유저정보가 변경되었습니다", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default){(action) in
                
            }
                
                
//            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//               self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
//            }

                alert.addAction(action)
            present(alert, animated: true, completion: nil)

        }

}


