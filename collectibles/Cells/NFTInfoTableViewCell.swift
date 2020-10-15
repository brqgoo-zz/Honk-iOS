//
//  NFTInfoTableViewCell.swift
//  collectibles
//
//  Created by Burak Keceli on 20.07.20.
//  Copyright © 2020 Burak Keceli. All rights reserved.
//

import UIKit

class NFTInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
  
    @IBOutlet weak var dsc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
