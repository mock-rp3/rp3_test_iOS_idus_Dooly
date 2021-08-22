//
//  AdTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/22.
//

import UIKit

class AdTableViewCell: UITableViewCell {

    @IBOutlet var AdCollectionView: UICollectionView!

    var addArr = [UIImage(named: "ad1"),UIImage(named: "ad2"),UIImage(named: "ad3"),UIImage(named: "ad4")]

    var timer : Timer?
    var currentIndex = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        AdCollectionView.delegate = self
        AdCollectionView.dataSource = self
        startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil ,  repeats: true)
    }
    
    @objc func timerAction(){
        let desiredScrollPosition = (currentIndex < addArr.count - 1) ? currentIndex + 1 : 0
        AdCollectionView.scrollToItem(at: IndexPath(item:desiredScrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


extension AdTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return addArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdCollectionViewCell", for: indexPath) as? AdCollectionViewCell else {return UICollectionViewCell()}
        
            cell.image.image = addArr[indexPath.row]
            return cell

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / AdCollectionView.frame.size.width)
    }


}
