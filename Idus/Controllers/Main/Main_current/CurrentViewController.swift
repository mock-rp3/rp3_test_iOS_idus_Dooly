//
//  CurrentViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class CurrentViewController: UIViewController {

    var productData: ProductModel?
    
    @IBOutlet var ItemTableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        loadJson()
        ItemTableView.delegate = self
        ItemTableView.dataSource = self

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
    
    
}

extension CurrentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentItemTableViewCell") as? CurrentItemTableViewCell else {
            return UITableViewCell()
        }
        
        cell.produts = productData?.response?[2]
        return cell
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemTableView.frame.height * 1.5
    }
 
    
}

