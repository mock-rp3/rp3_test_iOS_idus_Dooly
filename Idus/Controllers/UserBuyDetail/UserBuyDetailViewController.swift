//
//  UserBuyDetailViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import UIKit

class UserBuyDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let UserBuyDetailTableViewCell = UINib(nibName: "UserBuyDetailTableViewCell", bundle: nil)
        self.tableView.register(UserBuyDetailTableViewCell, forCellReuseIdentifier: "UserBuyDetailTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    @objc func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func goPayView(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PayDetailViewController") as? PayDetailViewController
        navigationController?.pushViewController(vc!, animated: true)

    }
    
}


extension UserBuyDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserBuyDetailTableViewCell", for: indexPath) as? UserBuyDetailTableViewCell else { return UITableViewCell()}
        return cell
        
        
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return tableView.frame.height * 0.7

    }
    
    
    
}
