//
//  UserBuyDetailTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/24.
//

import UIKit

class UserBuyDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var type: UILabel!
    
    @IBOutlet var price: UILabel!
    @IBOutlet var price2: UILabel!
    
    @IBOutlet var count: UILabel!
    
    @IBOutlet var writer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
