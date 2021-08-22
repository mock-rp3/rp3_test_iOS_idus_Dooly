//
//  ItemDetailFirstTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/19.
//

import UIKit

class ItemDetailFirstTableViewCell: UITableViewCell {

    @IBOutlet var sellerImage: UIImageView!
    @IBOutlet var sellerName: UILabel!
    
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var thumbIma: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    
    @IBOutlet var reviewCount: UILabel!
    
    
    var imageArr = [UIImage(named: "itemDetailImage1"), UIImage(named: "itemDetailImage1"),UIImage(named: "itemDetailImage1"),UIImage(named: "item_thumb1"),UIImage(named: "item_thumb1"),UIImage(named: "sub_category1"), UIImage(named: "item_thumb1"), UIImage(named: "item_thumb1"), UIImage(named: "white")]
    
    @IBOutlet var stackViewImage1: UIImageView!
    @IBOutlet var stackViewImage2: UIImageView!
    @IBOutlet var stackViewImage3: UIImageView!
    @IBOutlet var stackViewImage4: UIImageView!
    @IBOutlet var stackViewImage5: UIStackView!
    @IBOutlet var stackVIewImage6: UIImageView!
    @IBOutlet var stackViewImage7: UIImageView!
    @IBOutlet var stackViewImage8: UIImageView!
    @IBOutlet var stackViewImage9: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpImage()
            
    }
    
    func setUpImage(){

        stackViewImage1.image = imageArr[0]
        stackViewImage1.image = imageArr[1]
        stackViewImage1.image = imageArr[2]
        stackViewImage1.image = imageArr[3]
        stackViewImage1.image = imageArr[4]
        stackViewImage1.image = imageArr[5]
        stackViewImage1.image = imageArr[6]
        stackViewImage1.image = imageArr[7]
        stackViewImage1.image = imageArr[8]
        stackViewImage1.image = imageArr[8]

//        for i in 0...8 {
//            if ( i < imageArr.count) {
//                stackView[i].image = imageArr[i]
//                stackViewImage1.image = imageArr[i]
//            } else {
//                stackViewImage1.image = UIImage(named: "white")
//            }
//        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
