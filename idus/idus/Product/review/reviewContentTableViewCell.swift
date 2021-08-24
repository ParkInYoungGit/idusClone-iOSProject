//
//  reviewContentTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/25.
//

import UIKit

class reviewContentTableViewCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var createdDate: UILabel!
    @IBOutlet weak var reviewPhoto: UIImageView!
    @IBOutlet weak var reviewContent: UILabel!
    @IBOutlet weak var option: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
