//
//  MyInfoViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

class MyInfoViewController: UIViewController {

    
    var userInfo : GetUserInfoRes? = nil
    
    @IBOutlet var MyInfoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 이거 이 전페이지에서 한담에 배열을넘길수있도록 하셈
        // 유저 인덱스도 가지고 있다가 같이 쏴줘야함
            GetMyInfo().getUserInfo(self, token: "eyJ0eXBlIjoiand0IiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWR4Ijo0MSwiaWF0IjoxNjI5OTU0NDEzLCJleHAiOjE2MzE0MjU2NDJ9.x9-TUhf4L8khpXs-hi40PkqaYyG1UgnpXPfazFeglPo")
        
        MyInfoTableView.dataSource = self
        MyInfoTableView.delegate = self

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
            return 1
        }
        else if (section == 1) {
            return 2
        }
        else if (section == 3) {
            return 1
        }
        else if (section == 4) {
            return 3
        }
        else {
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyInfoTableViewCell") as? MyInfoTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0) {
    
        return tableView.frame.height * 0.45
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

    
}
