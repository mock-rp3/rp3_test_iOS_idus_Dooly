//
//  ClassOnlineReviewTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

class ClassOnlineReviewTableViewCell: UITableViewCell {
    
    @IBOutlet var ClassOnlineReviewCollectionView: UICollectionView!
    
    
    var classes: Class?{
        didSet{
            ClassOnlineReviewCollectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

        ClassOnlineReviewCollectionView.delegate = self
        ClassOnlineReviewCollectionView.dataSource = self

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension ClassOnlineReviewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classes?.reviews?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassOnlineReviewCollectionViewCell", for: indexPath) as? ClassOnlineReviewCollectionViewCell else {return UICollectionViewCell()}
        
        
        cell.image.image = UIImage(named: (classes?.reviews![indexPath.row].thumbReview)! )
        cell.classImage.image = UIImage(named: (classes?.reviews![indexPath.row].thumbClass)!)
        cell.review.text = classes?.reviews![indexPath.row].description
        cell.classDisc.text = classes?.reviews![indexPath.row].classDiscrip

        cell.view.layer.borderWidth = 1
        cell.view.layer.borderColor = UIColor.lightGray.cgColor
        cell.image.layer.cornerRadius = 10
        cell.view.layer.cornerRadius = 10
        cell.classImage.layer.cornerRadius = 10
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)

    }
}

