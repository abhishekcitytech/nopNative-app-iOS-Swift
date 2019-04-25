//
//  STCellTABLE.swift
//  nopcommerce app
//
//  Created by Sandipan on 29/01/19.
//  Copyright © 2019 SANDIPAN. All rights reserved.
//

import UIKit

class STCellTABLE: UITableViewCell {

    @IBOutlet var floatRatingView: FloatRatingView!
    
    @IBOutlet var imgvProduct: UIImageView!
    @IBOutlet var lblname: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var btnAddFav: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
