//
//  ClassOnlineCollectionViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import UIKit

class ClassOnlineCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var ad_image: UIImageView!
    
    var imageview: UIImage!{
        didSet{
            ad_image.image = imageview

        }
    }
}
