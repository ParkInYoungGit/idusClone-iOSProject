//
//  File.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import Foundation
import PagingKit

class MenuCell3: PagingMenuViewCell {
    @IBOutlet weak var lblMenuCell3: UILabel!
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                lblMenuCell3.textColor = UIColor.orange
            } else {
                lblMenuCell3.textColor = UIColor.lightGray
            }
        }
    }
    
    
}
