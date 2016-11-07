//
//  MedicinesTableViewCell.swift
//  SCMC ICU meds
//
//  Created by HotRod on 1/31/16.
//  Copyright © 2016 Rod Elliott-Mullens. All rights reserved.
//

import UIKit
import ParseUI

class MedicinesTableViewCell: PFTableViewCell {

    @IBOutlet weak var mainName: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
