//
//  NewViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class NewViewController: UIViewController {

    var productData: ProductModel?
    
    @IBOutlet var NewProductTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadJson()
        NewProductTableView.delegate = self
        NewProductTableView.dataSource = self

    }
    
    
    func loadJson(){
        if let path = Bundle.main.path(forResource: "productName", ofType:"json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let jsonData = try JSONSerialization.data(withJSONObject: jsonResult, options: .prettyPrinted)
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                productData = try jsonDecoder.decode(ProductModel.self, from: jsonData)
            }catch{
                print(error)
            }
        }
        
        
    }

}


extension NewViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewItemTableViewCell") as? NewItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.produts = productData?.response?[2]
        return cell
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NewProductTableView.frame.height * 1.5
    }
 
    
}
