//
//  MenuCell2.swift
//  idus
//
//  Created by YOUNG on 2021/08/22.
//

import Foundation
import PagingKit


class MenuCell2: PagingMenuViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                lblTitle.textColor = UIColor.orange
            } else {
                lblTitle.textColor = UIColor.lightGray
            }
        }
    }
    
}
