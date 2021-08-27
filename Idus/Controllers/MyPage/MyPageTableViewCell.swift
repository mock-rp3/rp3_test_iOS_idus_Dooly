//
//  MyPageTableViewCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/26.
//

import UIKit

protocol GoDelegate {
    func clickUserInfo()
}

class MyPageTableViewCell: UITableViewCell {

    var cellDelegate2: GoDelegate?
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var userLevel: UILabel!
    override func awakeFromNib() {
        userName.text = UserDefaults.standard.value(forKey: "name") as? String
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func goUserInfo(_ sender: UIButton) {
        cellDelegate2!.clickUserInfo()
    }
}
