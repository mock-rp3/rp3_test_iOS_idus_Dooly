//
//  ClassOnlineViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/20.
//

import UIKit

class ClassOnlineViewController: UIViewController {

    @IBOutlet var ClassOnlineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ClassOnlineTableView.delegate = self
        ClassOnlineTableView.dataSource = self
    }
    
}

extension ClassOnlineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOnlineTableViewCell") as? ClassOnlineTableViewCell else {return UITableViewCell()}
            return cell

        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOnlineCategoryTableViewCell") as? ClassOnlineCategoryTableViewCell else {return UITableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    
        switch indexPath.section{
        case 0 :
            return ClassOnlineTableView.frame.height * 0.28
        case 1 :
            return ClassOnlineTableView.frame.height * 0.12

        default :
            return tableView.frame.height * 0.25
            
        }
    }
}
