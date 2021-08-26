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
    
    
    var imageArr = [UIImage(named: "item1_thumb"), UIImage(named: "item1_thumb-1"),UIImage(named: "item1_thumb-2"),UIImage(named: "item1_thumb-3")]

    @IBOutlet var stackViewImage1: UIImageView!
    @IBOutlet var stackViewImage2: UIImageView!
    @IBOutlet var stackViewImage3: UIImageView!
    @IBOutlet var stackViewImage4: UIImageView!
//    @IBOutlet var stackViewImage5: UIButton!
//    @IBOutlet var stackVIewImage6: UIImageView!
//    @IBOutlet var stackViewImage7: UIImageView!
//    @IBOutlet var stackViewImage8: UIImageView!
//    @IBOutlet var stackViewImage9: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
