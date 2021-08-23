//
//  ProductTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/16.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet var itemCollectionView: UICollectionView!
    
    @IBOutlet var categoryName: UILabel!
    
    var produts: Product?{
        didSet{
            categoryName.text = produts?.categoryName
            itemCollectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onClickSeeMore(_ sender: Any) {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0))
    }
    
}



extension ProductTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        produts?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else{
            return UICollectionViewCell()
        }
                
        cell.productName.text = produts?.products?[indexPath.row].name
        cell.img.image = UIImage(named: produts?.products?[indexPath.row].imageName ?? "")
        return cell
    }
    
}
