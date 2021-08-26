//
//  ItemListTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {

    @IBOutlet var ItemListCollectionView: UICollectionView!

    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    
    var produts: Product?{
        didSet{
            ItemListCollectionView.reloadData()
        }
    }



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        ItemListCollectionView.delegate = self
        ItemListCollectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension ItemListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        produts?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemListCollectionViewCell", for: indexPath) as? ItemListCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.title.text = produts?.products?[indexPath.row].name
        cell.image.image = UIImage(named: produts?.products?[indexPath.row].imageName ?? "")
        cell.review.text = produts?.products?[indexPath.row].description
        cell.writer.text = "팔레트"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
       
            let width = ItemListCollectionView.frame.width
            let height = ItemListCollectionView.frame.height
            
            let itemsPerRow: CGFloat = 2
            let widthPadding = sectionInsets.left * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 3
            let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
            
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
          return sectionInsets
        }
        
        func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return sectionInsets.left
        }
    
}
