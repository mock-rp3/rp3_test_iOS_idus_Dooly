//
//  Product2TableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/22.
//

import UIKit

class Product2TableViewCell: UITableViewCell {
    
    @IBOutlet var Product2CollectionView: UICollectionView!
    
    @IBOutlet var categoryName: UILabel!
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    
    var produts: Product?{
        didSet{
            categoryName.text = produts?.categoryName
            Product2CollectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Product2CollectionView.delegate = self
        Product2CollectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0))
    }

}


extension Product2TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return produts?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Product2CollectionViewCell", for: indexPath) as? Product2CollectionViewCell else{
            return UICollectionViewCell()
        }
        
        cell.productImage.image = UIImage(named: produts?.products?[indexPath.row].imageName ?? "")
        cell.productName.text = produts?.products?[indexPath.row].name

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
       
            let width = Product2CollectionView.frame.width
            let height = Product2CollectionView.frame.height
            
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
