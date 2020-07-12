//
//  PinLocationTableViewCell.swift
//  OnTheMap
//
//  Created by Julia Debecka on 09/07/2020.
//  Copyright © 2020 Julia Debecka. All rights reserved.
//

import UIKit

class PinLocationTableViewCell: UITableViewCell {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var linkLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
