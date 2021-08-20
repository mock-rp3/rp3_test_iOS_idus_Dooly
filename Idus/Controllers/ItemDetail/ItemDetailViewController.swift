//
//  ItemDetailViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/18.
//

import UIKit

class ItemDetailViewController: UIViewController  {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buyBtn: UIButton!
    @IBOutlet var presentBtn: UIButton!
    @IBOutlet var floatingView: UIView!
    
    
    var ItemDetailData = GetItemDetailRes()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetItemDetailReq().getItemData(self, itemIdx: 1)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self

        let ItemDetailFirstTableViewCell = UINib(nibName: "ItemDetailFirstTableViewCell", bundle: nil)
        self.tableView.register(ItemDetailFirstTableViewCell, forCellReuseIdentifier: "ItemDetailFirstTableViewCell")
        
        let ItemDetailSecondTableViewCell = UINib(nibName: "ItemDetailSecondTableViewCell", bundle: nil)
        self.tableView.register(ItemDetailSecondTableViewCell, forCellReuseIdentifier: "ItemDetailSecondTableViewCell")
        
        
        presentBtn.layer.borderColor = UIColor.orange.cgColor
        presentBtn.layer.cornerRadius = 3
        presentBtn.layer.borderWidth = 1

        buyBtn.layer.borderColor = UIColor.orange.cgColor
        buyBtn.layer.cornerRadius = 10
        
        
        floatingView.layer.cornerRadius = floatingView.frame.height/2
        floatingView.layer.borderWidth = 1
        floatingView.clipsToBounds = true
        
        floatingView.layer.borderColor = UIColor.lightGray.cgColor
        floatingView.layer.borderWidth = 1
        floatingView.layer.shadowColor = UIColor.lightGray.cgColor
        floatingView.layer.shadowOffset = CGSize.zero
        floatingView.layer.shadowRadius = 6
        floatingView.layer.shadowOpacity = 1.0
        
        floatingView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
    }
    
    
    @IBAction func cchimBtn(_ sender: Any) {
    }
    
    @IBAction func buyBtn(_ sender: Any) {
        
    }
    
}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailFirstTableViewCell", for: indexPath) as? ItemDetailFirstTableViewCell else { return UITableViewCell()}
            
    //        cell.itemImage.image = UIImage(named: ProductDetails.name)
            cell.itemName.text = ItemDetailData.result?.title
            
            if let a = ItemDetailData.result?.finalPrice {
                cell.itemPrice.text = "\(a)"
            }
            return cell

        } else if (indexPath.row == 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailSecondTableViewCell", for: indexPath) as? ItemDetailSecondTableViewCell else { return UITableViewCell()}
            return cell
     
        } else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0 :
            let height = tableView.frame.height
            print(height)
            return height * 1.15
        case 1 :
            let height = tableView.frame.height
            return height * 0.6
        default :
            let height = view.frame.height
            return height
        }

    }
    

}

extension ItemDetailViewController {
    
    func didSuccess(_ response: GetItemDetailRes) {
        
        ItemDetailData = response
        tableView.reloadData()
        
    }
    
    func didFailure(_ message: String) {
        
        let alert = UIAlertController(title: "아이템 데이터가 없습니다", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
                     
    }

    
}
