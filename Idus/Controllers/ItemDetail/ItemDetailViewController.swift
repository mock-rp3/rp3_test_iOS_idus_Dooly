//
//  ItemDetailViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/18.
//

import UIKit

class ItemDetailViewController: UIViewController  {
    
    @IBOutlet var tableView: UITableView!

    
    var productDetails: ProductDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailsTableCell") as? ItemDetailsTableCell else {
            return UITableViewCell()
        }
        
//        cell.itemImage.image = UIImage(named: ProductDetails.name)
        
        cell.itemName.text = "테스트 아이템"
        cell.itemPrice.text = "13000원"
        
        return cell
    }
    
    
    
    
}
