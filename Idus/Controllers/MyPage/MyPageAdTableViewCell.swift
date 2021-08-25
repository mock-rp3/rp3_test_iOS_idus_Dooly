//
//  MyPageAdTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

class MyPageAdTableViewCell: UITableViewCell {

    @IBOutlet var myPageAdCollectionView: UICollectionView!
    
    
    
    var addArr = [UIImage(named: "myPage_ad1"),UIImage(named: "myPage_ad2"),UIImage(named: "myPage_ad3"),UIImage(named: "myPage_ad4")]

    var timer : Timer?
    var currentIndex = 0

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        myPageAdCollectionView.delegate = self
        myPageAdCollectionView.dataSource = self
        
        startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil ,  repeats: true)
    }

    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < addArr.count - 1) ? currentIndex + 1 : 0
        myPageAdCollectionView.scrollToItem(at: IndexPath(item:desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension MyPageAdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return addArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPageAdCollectionViewCell", for: indexPath) as? MyPageAdCollectionViewCell else {return UICollectionViewCell()}
        
            cell.adImage.image = addArr[indexPath.row]
            return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / myPageAdCollectionView.frame.size.width)
    }


}
