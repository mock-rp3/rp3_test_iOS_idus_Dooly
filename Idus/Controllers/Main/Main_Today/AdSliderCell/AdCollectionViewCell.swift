//
//  AdCollectionViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var image: UIImageView!
    
    var imageview: UIImage!{
        didSet{
            image.image = imageview

        }
    }
}
