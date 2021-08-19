//
//  todayTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/19.
//

import UIKit

//protocol CollectionViewCellDelegate: class {
//    func collectionView(collectionviewcell: CollectionViewCell?, index: Int, didTappedInTableViewCell: todayTableViewCell)
//    // other delegate methods that you can define to perform action in viewcontroller
//}

class todayTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var cellDelegate: UICollectionViewDelegate?
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell
//        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath, didTappedInTableViewCell: self)
//    }
//
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as? CollectionViewCell {
            cell.collectionImg.image = UIImage(named: "signup.png")
            return cell
        }
        return UICollectionViewCell()
    }
    
    @IBOutlet weak var todayTvImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 180)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.collectionView.collectionViewLayout = flowLayout
        self.collectionView.showsHorizontalScrollIndicator = false
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
