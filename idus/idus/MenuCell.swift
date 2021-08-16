//
//  MenuCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/15.
//
import UIKit
import PagingKit

class MenuCell: PagingMenuViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                titleLabel.textColor = UIColor.orange
            } else {
                titleLabel.textColor = UIColor.lightGray
            }
        }
    }
}
