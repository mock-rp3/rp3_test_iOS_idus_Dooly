//
//  AdCollectionViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    @IBOutlet var adImage: UIImageView!

    
    var image:UIImage!{
        didSet{
            adImage.image = image
            
        }
    }
}
