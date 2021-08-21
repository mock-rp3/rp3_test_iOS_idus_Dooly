//
//  MenuCell.swift
//  Idus
//
//  Created by 김희진 on 2021/08/15.
//

import Foundation
import PagingKit

class MenuCell: PagingMenuViewCell{
    
    @IBOutlet weak var titleLabel:UILabel!

    override public var isSelected: Bool {
            didSet {
                if isSelected {
                    
                    titleLabel.textColor = UIColor.orange
                    
                } else {
                    titleLabel.textColor = UIColor.gray
                }
            }
        }
    
}
