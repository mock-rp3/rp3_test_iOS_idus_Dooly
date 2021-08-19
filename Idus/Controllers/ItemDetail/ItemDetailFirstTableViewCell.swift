//
//  ItemDetailFirstTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/19.
//

import UIKit

class ItemDetailFirstTableViewCell: UITableViewCell {


    @IBOutlet var sellerName: UILabel!
    
    @IBOutlet var itemName: UILabel!
    
    @IBOutlet var itemPrice: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
