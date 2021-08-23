//
//  WorkViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/23.
//

import UIKit

class CategoryWorkViewController: UIViewController {

    var categoryData: CategoryModel?
    
    @IBOutlet var CategoryWorkTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadJson()
        
        CategoryWorkTableView.delegate = self
        CategoryWorkTableView.dataSource = self
    }
    
    
    func loadJson(){
        if let path = Bundle.main.path(forResource: "categoryName", ofType:"json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                categoryData = try jsonDecoder.decode(CategoryModel.self, from: jsonData)
            }catch{
            }
        }
        
    }
}




    
extension CategoryWorkViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryWorkTableViewCell") as? CategoryWorkTableViewCell else {
            return UITableViewCell()
        }
        cell.category = categoryData?.response?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return tableView.frame.height * 2.5
    }
}
