//
//  TodayViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class TodayViewController: UIViewController, UIGestureRecognizerDelegate {

//    @IBOutlet var adView: UIView!
    
    @IBOutlet var addCollectionView: UICollectionView!
    @IBOutlet var subCategoryCollectionView: UICollectionView!
    
    var addArr = [UIImage(named: "ad1"),UIImage(named: "ad2"),UIImage(named: "ad3"),UIImage(named: "ad4")]
    var suvCategoryArr = [UIImage(named: "sub_category1"), UIImage(named: "sub_category2"),UIImage(named: "sub_category3"),UIImage(named: "sub_category4"),UIImage(named: "sub_category5")]

    
    var timer : Timer?
    var currentIndex = 0

    var productData: ProductModel?

    
    @IBOutlet var tableView: UITableView!

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(TodayViewController.respondToSwipeGesture(_:)))
        
        swipeRight.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeRight)
        
        loadJson()
        tableView.delegate = self
        tableView.dataSource = self
    
        startTimer()
        
        
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil ,  repeats: true)
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
    
    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < addArr.count - 1) ? currentIndex + 1 : 0
        addCollectionView.scrollToItem(at: IndexPath(item:desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{

            switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.down:
                    print("2")
                default :
                    print("1")
                    break
                }
        }
    }

}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == addCollectionView{
            return addArr.count
        }else {
            return suvCategoryArr.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == addCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCollectionViewCell", for: indexPath) as! AdCollectionViewCell
            
            cell.adImage.image = addArr[indexPath.row]
            return cell

        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionViewCell", for: indexPath) as! DetailCollectionViewCell
            
            cell.imgImage.image = suvCategoryArr[indexPath.row]
            return cell
 
        }
        
               
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == addCollectionView{
            print(addCollectionView.frame)
            return CGSize(width: addCollectionView.frame.width, height: addCollectionView.frame.height)
        }else{
            return CGSize(width: subCategoryCollectionView.frame.width, height: subCategoryCollectionView.frame.height)

        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / addCollectionView.frame.size.width)
     
    }
    
    
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData?.response!.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as? ProductTableViewCell else {
            return UITableViewCell()
        }
        cell.produts = productData?.response?[indexPath.row]
        return cell
    }


}
