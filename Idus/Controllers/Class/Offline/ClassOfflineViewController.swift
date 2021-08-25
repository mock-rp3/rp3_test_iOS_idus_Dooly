//
//  ClassOfflineViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/20.
//

import UIKit

class ClassOfflineViewController: UIViewController {
    
    @IBOutlet var ClassOfflineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ClassOfflineTableView.delegate = self
        ClassOfflineTableView.dataSource = self

    }

}


extension ClassOfflineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if (indexPath.row == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOfflineTableViewCell") as? ClassOfflineTableViewCell else {return UITableViewCell()}
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOfflineCategoryTableViewCell") as? ClassOfflineCategoryTableViewCell else {return UITableViewCell()}
            return cell
        }

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    
        if (indexPath.row == 0){
            return ClassOfflineTableView.frame.height * 0.53
        }
        else {
            return ClassOfflineTableView.frame.height * 0.4
        }
            
    }
    
}

