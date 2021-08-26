//
//  PayDetailViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import UIKit

class PayDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var priceShowView: UILabel!
    
    @IBOutlet var priceFloatView: UIView!
    
    var totalPrice = 0
    var itemName = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let SectionAddressPayDetailTableViewCell = UINib(nibName: "SectionAddressPayDetailTableViewCell", bundle: nil)
        self.tableView.register(SectionAddressPayDetailTableViewCell, forCellReuseIdentifier: "SectionAddressPayDetailTableViewCell")


        let SectionDiscountTableViewCell = UINib(nibName: "SectionDiscountTableViewCell", bundle: nil)
        self.tableView.register(SectionDiscountTableViewCell, forCellReuseIdentifier: "SectionDiscountTableViewCell")
        
        
        let SectionBuyWayTableViewCell = UINib(nibName: "SectionBuyWayTableViewCell", bundle: nil)
        self.tableView.register(SectionBuyWayTableViewCell, forCellReuseIdentifier: "SectionBuyWayTableViewCell")

        let SectionPriceTableViewCell = UINib(nibName: "SectionPriceTableViewCell", bundle: nil)
        self.tableView.register(SectionPriceTableViewCell, forCellReuseIdentifier: "SectionPriceTableViewCell")

        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        tableView.tableFooterView = footer
        
        priceShowView.text = "\(totalPrice + 2500)원 간편하게 카드결제"
        priceFloatView.layer.cornerRadius = 3
    }
    
 
    @IBAction func buyFinal(_ sender: Any) {
        
        PostItemDetails().postItemOptions(self, userIdx: UserDefaults.standard.value(forKey: "userIdx")! as! Int)

    }
    
}


extension PayDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if (indexPath.section == 0) {

            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PayDetailTableViewCell") as? PayDetailTableViewCell else {
                return UITableViewCell()
            }
            return cell

        }
        else if ( indexPath.section == 1) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionAddressPayDetailTableViewCell") as? SectionAddressPayDetailTableViewCell else {
                return UITableViewCell()
            }
            return cell

        }
        else if ( indexPath.section == 2) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PayDetailTableViewCell2") as? PayDetailTableViewCell else {
                return UITableViewCell()
            }
            cell.itemName.text = itemName
            return cell

        }
        else if ( indexPath.section == 3) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionDiscountTableViewCell") as? SectionDiscountTableViewCell else {
                return UITableViewCell()
            }
            return cell

        }
        else if ( indexPath.section == 4) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionBuyWayTableViewCell") as? SectionBuyWayTableViewCell else {
                return UITableViewCell()
            }
            return cell

        }
        else if ( indexPath.section == 5) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SectionPriceTableViewCell") as? SectionPriceTableViewCell else {
                return UITableViewCell()
            }
            
            cell.price.text = "\(totalPrice)원"
            cell.totalPrice.text = "\(totalPrice + 2500)원"

            return cell

        }
        else if ( indexPath.section == 6) {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PayDetailTableViewCell3") as? PayDetailTableViewCell else {
                return UITableViewCell()
            }
            return cell

        }


        else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0 || indexPath.section == 2) {
            return 50
        }
        else if (indexPath.section == 1) {
            return tableView.frame.height * 0.35
        }
        else if (indexPath.section == 3) {
            return tableView.frame.height * 0.17
        }
        else if (indexPath.section == 4) {
            return tableView.frame.height * 0.64
        }
        else if (indexPath.section == 5) {
            return tableView.frame.height * 0.3
        }
        else {
            return 50
        }

    }
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            return 0
        }
        else {
            return 10
        }
    }
}

extension PayDetailViewController {
    

    func didBuySuccess(_ response: PostBuyItemRes) {
        
            let alert = UIAlertController(title: "", message: "구매가 완료되었습니다", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default){(action) in

                
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                
            

//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailViewController") as? ItemDetailViewController
//
//                self.navigationController?.pushViewController(vc!, animated: true)
               
                
                
            }
        
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
    
    
    }

}
