//
//  TodayViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class TodayViewController: UIViewController, UIGestureRecognizerDelegate {


    var productData: ProductModel?

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

//        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(TodayViewController.respondToSwipeGesture(_:)))
//
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.down
//        self.view.addGestureRecognizer(swipeRight)
        
        loadJson()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
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
    
    
    
//    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
//
//            switch swipeGesture.direction {
//                case UISwipeGestureRecognizer.Direction.down:
//                    print("2")
//                default :
//                    print("1")
//                    break
//                }
//        }
//    }
        

}


extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return 1
        }
        else if(section == 1) {
            return 1
        }
        else if(section == 2) {
//            return productData?.response!.count ?? 0
            return 2
        }
        else {
            return 1
        }
        
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell") as? AdTableViewCell else {return UITableViewCell()}
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell") as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
                return UITableViewCell()
            }
            cell.produts = productData?.response?[indexPath.row]
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Product2TableViewCell") as? Product2TableViewCell else {
                return UITableViewCell()
            }
            cell.produts = productData?.response?[2]
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                    
            switch indexPath.section{
            case 0 :
                return tableView.frame.height * 0.25
            case 2 :
                return tableView.frame.height * 0.45
            case 1 :
                return tableView.frame.height * 0.1
            case 3 :
                return tableView.frame.height * 1.3

            default :
                return tableView.frame.height * 0.25
                
            }
        }
 
    
}
