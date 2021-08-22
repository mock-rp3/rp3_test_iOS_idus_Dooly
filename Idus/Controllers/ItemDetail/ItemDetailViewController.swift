//
//  ItemDetailViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/18.
//

import UIKit

class ItemDetailViewController: UIViewController  {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buyOptionSetTV: UITableView!
    @IBOutlet var selectTV1: UITableView!

    
    @IBOutlet var buyBtn: UIButton!
    @IBOutlet var presentBtn: UIButton!
    @IBOutlet var floatingView: UIView!
    @IBOutlet var bottomView: UIView!


    @IBOutlet var buyView: UIView!
    @IBOutlet var buyMainView: UIView!
    @IBOutlet var buyCloseView: UIImageView!
    @IBOutlet var buySelectView: UIView!
    @IBOutlet var optionCloseView: UIButton!
    @IBOutlet var buyCartbutton: UIButton!
    @IBOutlet var buyNowbutton: UIButton!
        
    
    var ItemDetailData = GetItemDetailRes()
    
    let ary = ["빨간색", "노란색", "파란색","초록색"]
   
    var countArr = [Int]()
    var buySetArr = [String]()
    var priceArr = [Int]()
    var buyString = ""
    var buyPrice = 0
    var index = 0
    
    var test = [Bool]()
    var selectState = false
    var selectedCount = 0
    var tempOp = ""
    var step = 0
    var tempPrice = 0

    @IBOutlet var totalCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyMainView.layer.cornerRadius = 8
        
        GetItemDetailReq().getItemData(self, itemIdx: 1)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        selectTV1.delegate =  self
        selectTV1.dataSource = self
        buyOptionSetTV.dataSource = self
        buyOptionSetTV.delegate = self
        
        tableView.tag = 0
        selectTV1.tag = 1
        buyOptionSetTV.tag = 2

        let ItemDetailFirstTableViewCell = UINib(nibName: "ItemDetailFirstTableViewCell", bundle: nil)
        self.tableView.register(ItemDetailFirstTableViewCell, forCellReuseIdentifier: "ItemDetailFirstTableViewCell")
        
        let ItemDetailSecondTableViewCell = UINib(nibName: "ItemDetailSecondTableViewCell", bundle: nil)
        self.tableView.register(ItemDetailSecondTableViewCell, forCellReuseIdentifier: "ItemDetailSecondTableViewCell")

        let ItemDetailThirdTableViewCell = UINib(nibName: "ItemDetailThirdTableViewCell", bundle: nil)
        self.tableView.register(ItemDetailThirdTableViewCell, forCellReuseIdentifier: "ItemDetailThirdTableViewCell")
        

        presentBtn.layer.borderColor = UIColor.orange.cgColor
        presentBtn.layer.cornerRadius = 3
        presentBtn.layer.borderWidth = 1

        buyBtn.layer.borderColor = UIColor.orange.cgColor
        buyBtn.layer.cornerRadius = 10
        
        
        buyCartbutton.layer.borderColor = UIColor.gray.cgColor
        buyCartbutton.layer.cornerRadius = 5

        buyNowbutton.layer.borderColor = UIColor.orange.cgColor
        buyNowbutton.layer.cornerRadius = 5

        
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
        
        bottomView.layer.addBorder([.top], color: UIColor.lightGray, width: 1.0)

        buySelectView.layer.addBorder([.top], color: UIColor.lightGray, width: 1.0)

       
        let tapClosing = UITapGestureRecognizer(target: self, action: #selector(self.tapClose(_:)))
        buyCloseView.isUserInteractionEnabled = true
        buyCloseView.addGestureRecognizer(tapClosing)
//
//        let tapCountPlus = UITapGestureRecognizer(target: self, action: #selector(self.tapPlus(_:)))
//        btn_plus.isUserInteractionEnabled = true
//        btn_plus.addGestureRecognizer(tapCountPlus)
//
//        let tapCountMinus = UITapGestureRecognizer(target: self, action: #selector(self.tapMinus(_:)))
//        btn_minus.isUserInteractionEnabled = true
//        btn_minus.addGestureRecognizer(tapCountMinus)

   
    }
    
    
    @IBAction func cchimBtn(_ sender: Any) {
    }
    
    @IBAction func buyBtn(_ sender: Any) {
        buyView.isHidden = false
        
    }
    
    @objc func tapClose(_ sender: UITapGestureRecognizer) {
        buyView.isHidden = true

    }
    
    @IBAction func tapOpenOption(_ sender: Any) {
        selectTV1.isHidden = false
        optionCloseView.isHidden = false

//        tableView.deselectRow(at: IndexPath(row: 0, section: 0), animated: true)
//        test[0] = !test[0]
//        tableView.reloadSections([0,0], with: .none)
//        selectedCount += 1

    }
    
    @IBAction func tapCloseOption(_ sender: Any) {
        selectTV1.isHidden = true
        optionCloseView.isHidden = true

    }
    
    
    @IBAction func deleteOptionSet(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: buyOptionSetTV)
        
        let indexpath = buyOptionSetTV.indexPathForRow(at: point)
        
        buySetArr.remove(at: indexpath!.row)
        priceArr.remove(at: indexpath!.row)
        countArr.remove(at: indexpath!.row)
        
        buyOptionSetTV.beginUpdates()
        buyOptionSetTV.deleteRows(at: [IndexPath(row:indexpath!.row, section:0)], with: .none)
        buyOptionSetTV.endUpdates()
        
        totalCount.text = "\(simpleArraySum(ar: priceArr))"
        
    }
   
    @IBAction func minusCount(_ sender: UIButton) {
//        let point = sender.convert(CGPoint.zero, to: buyOptionSetTV)
//        let indexpath = buyOptionSetTV.indexPathForRow(at: point)
//        print(indexpath!.row)
//        countArr[indexPath!.row] = countArr[indexPath.row] - 1
//        buyOptionSetTV.reloadData()
        
    }
    
    @IBAction func plusCount(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: buyOptionSetTV)
        let indexpath = buyOptionSetTV.indexPathForRow(at: point)

        countArr[indexpath!.row] = countArr[indexpath!.row] + 1
        
        totalCount.text = "\( Int(totalCount.text!)! + priceArr[indexpath!.row] )"
        
        buyOptionSetTV.reloadData()
    }
    
    func simpleArraySum(ar: [Int]) -> Int {
        return ar.reduce(0,+)
    }


    
}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 1 {
            return ItemDetailData.result?.option.count ?? 0
        }
        else {
            return 1

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0 {
            return 3
        }
        if tableView.tag == 1 {
            if ( test[section] == true){
                return (ItemDetailData.result?.detail!.count)! + 1
            }else{
                return 1
            }
//            return ItemDetailData.result?.detail?.count ?? 0
        }
        else {
            return buySetArr.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView.tag == 0 {
                if (indexPath.row == 0) {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailFirstTableViewCell", for: indexPath) as? ItemDetailFirstTableViewCell else { return UITableViewCell()}
            //        cell.itemImage.image = UIImage(named: ProductDetails.name)
                    
                    cell.itemName.text = ItemDetailData.result?.title
                    
                    if let a = ItemDetailData.result?.finalPrice {
                        cell.itemPrice.text = "\(a)"}
                    if let a = ItemDetailData.result?.reviewCount {
                        cell.reviewCount.text = "\(a)"}
                    
                    return cell
                } else if (indexPath.row == 1) {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailSecondTableViewCell", for: indexPath) as? ItemDetailSecondTableViewCell else { return UITableViewCell()}
                    return cell
                                                                                                    
                } else if (indexPath.row == 2) {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemDetailThirdTableViewCell", for: indexPath) as? ItemDetailThirdTableViewCell else { return UITableViewCell()}
                    return cell
                }
                else {
                    return UITableViewCell()
                }
        }
        
        else if tableView.tag == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            if (indexPath.row == 0){
                cell.textLabel?.text = "\(ItemDetailData.result?.option[indexPath.section].title ?? "")"
                cell.backgroundColor = .systemGray
                
            }else {
                cell.textLabel?.text = "\(ItemDetailData.result?.detail![indexPath.row-1].title ?? "")"
            }
            return cell

        }
        
        else  {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItemOpSetTableViewCell", for: indexPath) as? ItemOpSetTableViewCell else { return UITableViewCell()}
            
            
            cell.opSetString.text = buySetArr[indexPath.row]
            cell.opSetPrice.text = "\(priceArr[indexPath.row])"
            cell.opSetCount.text = "\(countArr[indexPath.row])"
//            cell.opSetPrice.text = "\(ItemDetailData.result?.option[indexPath.row].price)"
//                        cell.textLabel?.text = buySetArr[indexPath.row]


            return cell

            
        }
         
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if ( tableView.tag == 0 ) {
            
            switch indexPath.row{
            case 0 :
                let height = tableView.frame.height
                return height * 1.15
            case 1 :
                let height = tableView.frame.height
                return height * 0.6
            case 2 :
                let height = tableView.frame.height
                return height * 0.8

            default :
                let height = tableView.frame.height
                return height
            }
        }
        else if (tableView.tag == 1) {
            return 40
        }
        else {
            return 70
        }
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let totalcount = ItemDetailData.result?.option.count

        if ( tableView.tag == 0 || tableView.tag == 2){
        }
        else {
         
            if (selectedCount == 0 ){
                tableView.deselectRow(at: indexPath, animated: true)
                test[indexPath.section] = !test[indexPath.section]
            
                tableView.reloadSections([indexPath.section], with: .none)
                selectedCount += 1
            }
            if ( selectedCount == 1 ) {

                print(indexPath)
                let cell = tableView.cellForRow(at: indexPath)

                if(indexPath.row == 0){

                }else{
                    buyString = (cell?.textLabel?.text!)!
                    print(buyString)
                    print("!!")
                    tableView.deselectRow(at: indexPath, animated: true)
                    test[indexPath.section] = !test[indexPath.section]
                    tableView.reloadSections([indexPath.section], with: .none)
                    tempOp +=  (ItemDetailData.result?.option[indexPath.row - 1].title)! + ":" + buyString + "/"
                    tempPrice += (ItemDetailData.result?.option[indexPath.row - 1].price)!
                    print(tempOp)
                    print(tempPrice)
                    step += 1
                    selectedCount = 0
                }
            }
            if (step == totalcount ){
                    buyString = tempOp
                    buyPrice = tempPrice
                
                    self.buySetArr.insert(buyString, at: 0)
                    self.priceArr.insert(buyPrice, at: 0)
                    self.countArr.insert(1, at: 0)
    
                    buyOptionSetTV.beginUpdates()
                    buyOptionSetTV.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                    buyOptionSetTV.endUpdates()
                    
                    totalCount.text = "\(simpleArraySum(ar: priceArr))"
                
                    
                    selectTV1.isHidden = true
                    optionCloseView.isHidden = true
    
                    buyCartbutton.layer.backgroundColor = UIColor.white.cgColor
                    buyNowbutton.layer.borderColor = UIColor.orange.cgColor
                    
                    tempOp = ""
                    tempPrice = 0
                    step = 0
            }

        }
    }
    
}



extension ItemDetailViewController {
    
    func didSuccess(_ response: GetItemDetailRes) {
        
        ItemDetailData = response
        
        for _ in ItemDetailData.result!.option {
            test.append(false)
        }
        tableView.reloadData()
        selectTV1.reloadData()
        buyOptionSetTV.reloadData()
        
    }
    
    func didFailure(_ message: String) {
        
        let alert = UIAlertController(title: "아이템 데이터가 없습니다", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
                     
    }

    
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


