//
//  MyPageViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet var platform: UILabel!
    @IBOutlet var email: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var password: UILabel!
    
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("!!")
//        print(UserDefaults.standard.value(forKey: "name") as! String)

        if UserDefaults.standard.value(forKey: "email") != nil  && UserDefaults.standard.value(forKey: "password") != nil {
            email.text = (UserDefaults.standard.value(forKey: "email") as! String)
            name.text = (UserDefaults.standard.value(forKey: "name") as! String)
            password.text = (UserDefaults.standard.value(forKey: "password") as! String)
            platform.text = (UserDefaults.standard.value(forKey: "platform") as! String)
           
        }else {
            button.setTitle("로그인하러가기", for: .normal)
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("!!!!")

    }
    
    
    @IBAction func btnLogout(_ sender: Any) {
  
    
        
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "name")
        UserDefaults.standard.removeObject(forKey: "platform")
        
        
        
        
        print("logout")
        

        let vc = storyboard?.instantiateViewController(withIdentifier: "LogInViewController") as? LogInViewController

        navigationController?.pushViewController(vc!, animated: true)

    }
    

}
