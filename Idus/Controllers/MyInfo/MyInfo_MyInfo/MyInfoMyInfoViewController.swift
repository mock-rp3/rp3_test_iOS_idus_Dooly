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
        // Do any additional setup after loading the view.
    
        navigationController?.isNavigationBarHidden = false
        print(UserDefaults.standard.value(forKey: "email") as! String)
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
                return cell
            }
            if (indexPath.row == 1) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell1") as? ChangeInfoTableViewCell else {
                    return UITableViewCell()
                }
                return cell
            }
            
            if (indexPath.row == 2) {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangeInfoTableViewCell2") as? ChangeInfoTableViewCell else {
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
