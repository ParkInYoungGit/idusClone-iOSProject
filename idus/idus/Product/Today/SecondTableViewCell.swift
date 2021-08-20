//
//  SecondTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/20.
//

import UIKit

class SecondTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCV.dequeueReusableCell(withReuseIdentifier: "productCVCell", for: indexPath) as! ProductCollectionViewCell
        cell.cvProductImg.image = UIImage(named: "productImgSample.png")
        cell.cvProductTitle.text = "태극기 키링 / 무궁화 키링"
        cell.cvStarPoint.image = UIImage(named: "starPoint.png")
        cell.cvCommentCount.text = "(5)"
        
        return cell
    }
    
    @IBOutlet weak var productCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
      
        let halfWidth: CGFloat = UIScreen.main.bounds.width / 2.0
        flowLayout.itemSize = CGSize(width: halfWidth, height: 300)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        productCV.collectionViewLayout = flowLayout
        productCV.delegate = self
        productCV.dataSource = self
        
        let cellNib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCV.register(cellNib, forCellWithReuseIdentifier: "productCVCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    // 사이즈 결정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let itemSpacing: CGFloat = 10
//        let textAreaHeight: CGFloat = 80
//
//        let width: CGFloat = (productCV.bounds.width - itemSpacing) / 2
//        let height: CGFloat = width * 10/7 + textAreaHeight
//        return CGSize(width: width, height: height)
//    }
}
