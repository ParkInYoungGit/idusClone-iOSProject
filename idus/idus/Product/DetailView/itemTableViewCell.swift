//
//  itemTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/22.
//

import UIKit

class itemTableViewCell: UITableViewCell {

    @IBOutlet weak var sellerName: UILabel!
    @IBOutlet weak var itemName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
