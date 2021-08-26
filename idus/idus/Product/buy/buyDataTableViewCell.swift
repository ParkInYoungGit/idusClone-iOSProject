//
//  buyDataTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import UIKit

class buyDataTableViewCell: UITableViewCell {

    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var recieveName: UITextField!
    @IBOutlet weak var address: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
