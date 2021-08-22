//
//  ItemOpSetTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/21.
//

import UIKit

class ItemOpSetTableViewCell: UITableViewCell {

    @IBOutlet var opSetString: UILabel!
    @IBOutlet var opSetPrice: UILabel!
    @IBOutlet var opSetCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
    }

}
