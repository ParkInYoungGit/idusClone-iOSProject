//
//  optionTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/25.
//

import UIKit

class optionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
