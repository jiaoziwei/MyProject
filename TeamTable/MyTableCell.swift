//
//  MyTableCell.swift
//  TeamTable
//
//  Created by 陈嘉伟 on 16/1/27.
//  Copyright © 2016年 陈嘉伟. All rights reserved.
//

import UIKit

class MyTableCell: UITableViewCell {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var TeamImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
