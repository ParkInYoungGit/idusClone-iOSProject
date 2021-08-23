//
//  contentTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit

class contentTableViewCell: UITableViewCell {
    @IBOutlet weak var deliveryCharge: UILabel!
    @IBOutlet weak var freeShippingCondition: UILabel!
    @IBOutlet weak var deliveryDay: UILabel!
    @IBOutlet weak var totalStack: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var prodPolicyName: UILabel!
    @IBOutlet weak var prodPolicyDetail: UILabel!
    @IBOutlet weak var refundPolicyDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        content.numberOfLines = 0
        content.lineBreakMode = .byCharWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
