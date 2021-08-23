//
//  CategoryTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet var CategoryCollectionView: UICollectionView!
    
    var suvCategoryArr = [UIImage(named: "sub_category1"), UIImage(named: "sub_category2"),UIImage(named: "sub_category3"),UIImage(named: "sub_category4"),UIImage(named: "sub_category5"),UIImage(named: "sub_category1"), UIImage(named: "sub_category2"),UIImage(named: "sub_category3"),UIImage(named: "sub_category4"),UIImage(named: "sub_category5")]

    override func awakeFromNib() {
        super.awakeFromNib()
        CategoryCollectionView.delegate = self
        CategoryCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return suvCategoryArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        
            cell.image.image = suvCategoryArr[indexPath.row]
//            cell.label.text = suvCategoryStringArr[indexPath.row]
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        currentIndex = Int(scrollView.contentOffset.x / AdCollectionView.frame.size.width)
//    }


}

