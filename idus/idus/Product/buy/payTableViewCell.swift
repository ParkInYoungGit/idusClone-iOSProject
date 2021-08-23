//
//  payTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import UIKit

class payTableViewCell: UITableViewCell {

    @IBOutlet weak var payImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func btnPayChoice(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
