//
//  ItemDetailViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/18.
//

import UIKit
import ExpyTableView

struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [Any]()
    var clickedOption = Int()
}

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
    
    var TableViewData = [cellData]()

    var imageArr = [UIImage(named: "item1_thumb"), UIImage(named: "item1_thumb-1"),UIImage(named: "item1_thumb-2"),UIImage(named: "item1_thumb-3")]

    @IBOutlet var totalCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyMainView.layer.cornerRadius = 8
        
        GetItemDetailReq().getItemData(self, itemIdx: 4)
                
        
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
        let point = sender.convert(CGPoint.zero, to: buyOptionSetTV)
        let indexpath = buyOptionSetTV.indexPathForRow(at: point)

        countArr[indexpath!.row] = countArr[indexpath!.row] - 1
        
        totalCount.text = "\( Int(totalCount.text!)! - priceArr[indexpath!.row] )"
        
        buyOptionSetTV.reloadData()

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
    
    @IBAction func cart(_ sender: Any) {
        
        PostItemDetails().postCartOptions(self, userIdx: UserDefaults.standard.value(forKey: "userIdx")! as! Int)
    }
    

    @IBAction func buy(_ sender: Any) {

        buyView.isHidden = true

        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UserBuyDetailViewController") as! UserBuyDetailViewController

//        vc.price = simpleArraySum(ar: priceArr)
        vc.price = simpleArraySum(ar: priceArr) * countArr[0]
        vc.count = countArr[0]
        vc.itemTitle = ItemDetailData.result!.title
            
        if let a = ItemDetailData.result?.writer {
            vc.writer = a
        }
        
        vc.option = buySetArr[0]

        
        let navigationController = self.navigationController


        //          vc.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: vc, action: #selector(vc.closeView))
        
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: vc, action: #selector(vc.closeView))

        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromTop
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(vc, animated: false)
        
        
    }
    
}
extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.tag == 0 {
            return 1
        }
        if tableView.tag == 1 {
            return ItemDetailData.result?.option.count ?? 0
        }
        if ( tableView.tag == 2){
            return 1
        }
        else {
            return TableViewData.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 0 {
            return 3
        }
        if tableView.tag == 1 {
            if TableViewData[section].opened == true {
                return TableViewData[section].sectionData.count + 1
            }else{
                return 1
            }
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
                    
                    cell.sellerName.text = ItemDetailData.result?.writer
                    
                    cell.thumbIma.image = imageArr[0]
                    
                    
                    cell.stackViewImage1.image = imageArr[0]
                    cell.stackViewImage2.image = imageArr[1]
                    cell.stackViewImage3.image = imageArr[2]
                    cell.stackViewImage4.image = imageArr[3]
                    
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

            let cell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)

            if (indexPath.row == 0){
//                cell.textLabel?.text = "\(ItemDetailData.result?.option[indexPath.section].title ?? "")"
                cell.textLabel?.text = TableViewData[indexPath.section].title
                return cell
                
            }else{
                let x = TableViewData[indexPath.section].sectionData[indexPath.row - 1]

                var x2 = ""
                switch x {
                    case let x as Detail:
                        x2 = x.title!
                    case let x as Option:
                        x2 = x.title!
                    default: break
                }
                
                cell.textLabel?.text = x2
                return cell
               
            }

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
            return 30
        }
        else {
            return 80
        }
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if ( tableView.tag == 0 || tableView.tag == 2){
        }
        else {
        
            if TableViewData[indexPath.section].opened == true {
                                
                TableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
                
                if ( indexPath.row != 0 ) {
                    
                    let x = TableViewData[indexPath.section].sectionData[indexPath.row - 1]

                    let x1 = TableViewData[indexPath.section].title
                    var x2 = ""
                    var x3 = 0
                    switch x {
                        case let x as Detail:
                            x2 = x.title!
                            x3 = x.price!
                        case let x as Option:
                            x2 = x.title!
                            x3 = x.price!
                        default: break
                    }
                    
                    buyString = x2

//                    tableView.deselectRow(at: indexPath, animated: true)
                    tableView.reloadSections([indexPath.section], with: .none)

                    tempOp +=  x1 + ":" + x2 + " / "
                    tempPrice += x3
                    
                    step += 1

                }
                if (step == 2 ){
                        
                        buyString = tempOp
                        buyPrice = tempPrice

                        self.buySetArr.insert(buyString, at: 0)
                        self.priceArr.insert(buyPrice + ItemDetailData.result!.finalPrice, at: 0)
                        self.countArr.insert(1, at: 0)
                        
                        step  += 1
                }
                if (step == 3) {
                    selectTV1.isHidden = true
                    optionCloseView.isHidden = true
                    
                    
                    
                    buyOptionSetTV.beginUpdates()
                    buyOptionSetTV.insertRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                    buyOptionSetTV.endUpdates()

                    totalCount.text = "\(simpleArraySum(ar: priceArr))"

                    tempOp = ""
                    tempPrice = 0
                    step = 0
                }
                                
            }else{
//                openCloseBtn.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                TableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)

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
            
        TableViewData.append(cellData(opened: false, title:"디테일", sectionData: ItemDetailData.result!.detail! , clickedOption: 100 ))
               
        if let a = ItemDetailData.result{


            TableViewData.append(cellData(opened: false, title: a.option_name ?? "", sectionData: ItemDetailData.result!.option , clickedOption:100))
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

    func didCartSuccess(_ response: PostCartItemRes) {

        let alert = UIAlertController(title: "", message: "카트에 상품이 담겼습니다", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        buyView.isHidden = true

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


