//
//  STCell.swift
//  NeverEverWait
//
//  Created by Sabnam Nasrin on 29/10/18.
//  Copyright © 2018 SANDIPAN. All rights reserved.
//

import UIKit

class STCell: UICollectionViewCell {

    @IBOutlet var floatRatingView: FloatRatingView!
    
    @IBOutlet var imgvProduct: UIImageView!
    @IBOutlet var lbl1: UILabel!
    @IBOutlet var lbl2: UILabel!
    @IBOutlet var lbl3: UILabel!

    @IBOutlet var btnFav: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
