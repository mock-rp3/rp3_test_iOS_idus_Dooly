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
       return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOfflineTableViewCell") as? ClassOfflineTableViewCell else {return UITableViewCell()}
        return cell

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    
        return ClassOfflineTableView.frame.height * 0.4
            
    }
    
}

