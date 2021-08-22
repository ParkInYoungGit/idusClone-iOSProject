//
//  todayTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/19.
//

import UIKit
var productName = ""

protocol CVCellDelegate {
    func selectedCVCell(_ index: Int)
}


class todayTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    

    
    
    var collectionImgArr = ["baner1.png","baner2.png","baner3.png","baner4.png","baner5.png","baner6.png","baner8.png","baner9.png"]
    var AdImagArr = ["today1.jpeg","today2.jpeg","today3.jpeg"]
    weak var cellDelegate: UICollectionViewDelegate?
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adCollectionView {
            return AdImagArr.count
        } else {
            return collectionImgArr.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == adCollectionView {
            let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: "ADcollectionviewcellid", for: indexPath) as! AdCollectionViewCell
            cell.adImage.image = UIImage(named: AdImagArr[indexPath.row])
            cell.adImage.contentMode = .scaleAspectFit
            return cell
        } else {
            let cell = bcollectionView.dequeueReusableCell(withReuseIdentifier: "collectionviewcellid", for: indexPath) as! CollectionViewCell
            cell.collectionImg?.image = UIImage(named: collectionImgArr[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
   
    @IBOutlet weak var bcollectionView: UICollectionView!
    @IBOutlet weak var adCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 데이터 불러오기 API연결
        print("어디가먼저tableViewCell")
        

        
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 90, height: 80)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        self.bcollectionView.collectionViewLayout = flowLayout
        self.bcollectionView.showsVerticalScrollIndicator = false
        
        self.bcollectionView.dataSource = self
        self.bcollectionView.delegate = self
        
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.bcollectionView.register(cellNib, forCellWithReuseIdentifier: "collectionviewcellid")
        
        let flowLayout2 = UICollectionViewFlowLayout()
        flowLayout2.scrollDirection = .horizontal
        flowLayout2.itemSize = CGSize(width: 414, height: 200)
        flowLayout2.minimumLineSpacing = 0
        self.adCollectionView.collectionViewLayout = flowLayout2
        self.adCollectionView.showsVerticalScrollIndicator = false
        self.adCollectionView.dataSource = self
        self.adCollectionView.delegate = self
        
        let adCellNib = UINib(nibName: "AdCollectionViewCell", bundle: nil)
        self.adCollectionView.register(adCellNib, forCellWithReuseIdentifier: "ADcollectionviewcellid")
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

