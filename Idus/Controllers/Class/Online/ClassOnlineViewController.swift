//
//  ClassOnlineViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/20.
//

import UIKit

class ClassOnlineViewController: UIViewController {

    
    var classData: ClassModel?

    @IBOutlet var ClassOnlineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadJson()
        ClassOnlineTableView.delegate = self
        ClassOnlineTableView.dataSource = self
    }
    
    
    
    func loadJson(){
        if let path = Bundle.main.path(forResource: "className", ofType:"json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                classData = try jsonDecoder.decode(ClassModel.self, from: jsonData)
            }catch{
                print(error)
            }
        }
        
        
    }
    
}

extension ClassOnlineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if(indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOnlineTableViewCell") as? ClassOnlineTableViewCell else {return UITableViewCell()}
            return cell

        }
        else if(indexPath.section == 1){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOnlineCategoryTableViewCell") as? ClassOnlineCategoryTableViewCell else {return UITableViewCell()}
            return cell
        }
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClassOnlineReviewTableViewCell") as? ClassOnlineReviewTableViewCell else {return UITableViewCell()}
           
            cell.classes = classData?.response?[indexPath.row]
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    
        switch indexPath.section{
        case 0 :
            return ClassOnlineTableView.frame.height * 0.28
        case 1 :
            return ClassOnlineTableView.frame.height * 0.12
        case 2 :
            return ClassOnlineTableView.frame.height * 0.65
        default :
            return tableView.frame.height * 0.25
            
        }
    }
}
