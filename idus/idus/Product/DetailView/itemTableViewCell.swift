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
    @IBOutlet weak var sellerImg: UIImageView!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oriPrice: UILabel!
    @IBOutlet weak var numOfReview: UILabel!
    @IBOutlet weak var numberOfCustomer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
