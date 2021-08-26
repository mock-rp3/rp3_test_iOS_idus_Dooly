//
//  ItemListViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/18.
//

import UIKit

class ItemListViewController: UIViewController {
    
    var productData: ProductModel?

    @IBOutlet var ItemListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.isNavigationBarHidden = false
        loadJson()
        ItemListTableView.delegate = self
        ItemListTableView.dataSource = self

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


extension ItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListTableViewCell") as? ItemListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.produts = productData?.response?[3]
        return cell
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ItemListTableView.frame.height * 1.5
    }
 
    
}

