//
//  ProductCollectionViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/20.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cvProductImg: UIImageView!
    @IBOutlet weak var cvProductTitle: UILabel!
    @IBOutlet weak var cvStarPoint: UIImageView!
    @IBOutlet weak var cvCommentCount: UILabel!
    @IBOutlet weak var cvReview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

}

