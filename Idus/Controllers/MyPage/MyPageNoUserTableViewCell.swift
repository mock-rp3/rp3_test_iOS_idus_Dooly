//
//  MyPageNoUserTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

protocol MyCellDelegate {
    func clickLogin()
}

class MyPageNoUserTableViewCell: UITableViewCell {

    
    var cellDelegate: MyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func gotoLogin(_ sender: UIButton) {
        cellDelegate!.clickLogin()
    }
       
}
