//
//  TodayViewController.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class TodayViewController: UIViewController {

    @IBOutlet var sliderCollectionView: UICollectionView!

    @IBOutlet var adView: UIView!
    
    var addArr = [UIImage(named: "ad1"),UIImage(named: "ad1"),UIImage(named: "ad1"),UIImage(named: "ad1")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(adView)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

extension TodayViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let vc = cell.viewWithTag(111) as? UIImageView{
            vc.image = addArr[indexPath.row]
        }
        
        return cell
    }
    
    
}

extension TodayViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
