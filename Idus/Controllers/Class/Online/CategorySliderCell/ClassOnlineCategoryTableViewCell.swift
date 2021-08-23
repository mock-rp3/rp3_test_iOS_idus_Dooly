//
//  ClassOnlineCategoryTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import UIKit

class ClassOnlineCategoryTableViewCell: UITableViewCell {

    
    @IBOutlet var ClassOnlineCategoryCollectionView: UICollectionView!
    
    var suvCategoryArr = [UIImage(named: "class_category1"), UIImage(named: "class_category2"),UIImage(named: "class_category3"),UIImage(named: "class_category4"),UIImage(named: "sub_category5"),UIImage(named: "sub_category1"), UIImage(named: "class_category6"),UIImage(named: "class_category7"),UIImage(named: "class_category8"),UIImage(named: "class_category9")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ClassOnlineCategoryCollectionView.delegate = self
        ClassOnlineCategoryCollectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ClassOnlineCategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return suvCategoryArr.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassOnlineCategoryCollectionViewCell", for: indexPath) as? ClassOnlineCategoryCollectionViewCell else {return UICollectionViewCell()}
        
        cell.classCategoryImage.image = suvCategoryArr[indexPath.row]
            
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }
}
