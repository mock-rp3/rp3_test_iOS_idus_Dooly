//
//  CategoryWorkTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/23.
//

import UIKit

class CategoryWorkTableViewCell: UITableViewCell {
   
    @IBOutlet var CategoryWorkCollectionView: UICollectionView!
    
    var category: Category?{
        didSet{
            CategoryWorkCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        CategoryWorkCollectionView.delegate = self
        CategoryWorkCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CategoryWorkTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        category?.category?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryWorkCollectionViewCell", for: indexPath) as? CategoryWorkCollectionViewCell else{
            return UICollectionViewCell()
        }
                
        cell.image.image = UIImage(named:(category?.category![indexPath.row].categoryImage)! )
        cell.name.text = category?.category![indexPath.row].categoryWorkName
        
        return cell
    }
    
}
