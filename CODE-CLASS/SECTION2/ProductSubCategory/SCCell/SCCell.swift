//
//  SCCell.swift
//  nopcommerce app
//
//  Created by Sandipan on 27/02/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class SCCell: UITableViewCell {

    @IBOutlet var imgvProduct: UIImageView!
    @IBOutlet var lblname: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
