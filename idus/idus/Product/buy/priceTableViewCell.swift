//
//  priceTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import UIKit

class priceTableViewCell: UITableViewCell {
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var lblDelivery: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
