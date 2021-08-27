//
//  CurrentItemTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/23.
//

import UIKit

class CurrentItemTableViewCell: UITableViewCell {

    @IBOutlet var CurrentItemCollectionView: UICollectionView!
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    
    var produts: Product?{
        didSet{
            CurrentItemCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CurrentItemCollectionView.delegate = self
        CurrentItemCollectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CurrentItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentItemCollectionViewCell", for: indexPath) as? CurrentItemCollectionViewCell else{
            return UICollectionViewCell()
        }
                
//        cell.productName.text = produts?.products?[indexPath.row].name
//        cell.img.image = UIImage(named: produts?.products?[indexPath.row].imageName ?? "")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
       
            let width = CurrentItemCollectionView.frame.width
            let height = CurrentItemCollectionView.frame.height
            
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
