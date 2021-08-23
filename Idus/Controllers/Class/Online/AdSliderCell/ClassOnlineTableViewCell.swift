//
//  ClassOnlineTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import UIKit

class ClassOnlineTableViewCell: UITableViewCell {

    @IBOutlet var ClassOnlineCollectionView: UICollectionView!
    
    var addArr2 = [UIImage(named: "class_ad1"),UIImage(named: "class_ad2"),UIImage(named: "class_ad3"),UIImage(named: "class_ad4"), UIImage(named: "class_ad5")]

    var timer2 : Timer?
    var currentIndex2 = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ClassOnlineCollectionView.delegate = self
        ClassOnlineCollectionView.dataSource = self
        startTimer()
        
    }
    
    func startTimer(){
        timer2 = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction2), userInfo: nil ,  repeats: true)
    }
    
    @objc func timerAction2(){
        let desiredScrollPosition = (currentIndex2 < addArr2.count - 1) ? currentIndex2 + 1 : 0
        ClassOnlineCollectionView.scrollToItem(at: IndexPath(item:desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension ClassOnlineTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return addArr2.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassOnlineCollectionViewCell", for: indexPath) as? ClassOnlineCollectionViewCell else {return UICollectionViewCell()}
        
            cell.ad_image.image = addArr2[indexPath.row]
            return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex2 = Int(scrollView.contentOffset.x / ClassOnlineCollectionView.frame.size.width)
    }


}
