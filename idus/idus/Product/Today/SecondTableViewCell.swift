//
//  SecondTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/20.
//

import UIKit



class SecondTableViewCell: UITableViewCell{
    
    var itemArr: [todayResult?] = []

    var dataManager = todayViewDataManager()
    
    var delegate: CVCellDelegate?
   // var itemTitleArr = item.init(itemNameArr: )
    
    @IBOutlet weak var productCV: UICollectionView!
    
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        print("어디가먼저secondViewCell")

        productCV.delegate = self
        productCV.dataSource = self
        
        let cellNib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        productCV.register(cellNib, forCellWithReuseIdentifier: "productCVCell")
        productCV.collectionViewLayout = createCompositionalLayout()
        
        dataManager.getProduct(delegate: self)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 7, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.7))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}


extension SecondTableViewCell {
    func didSuccessProduct(data: todayRes) {
        print("result확인>>>\(data)")
            //items.itemNameArr.append(data[i]!.itemName)
        itemArr = data.result
        productCV.reloadData()
        print("arr확인>>>>>\(itemArr)")
    }
    func failedToRequest(message: String) {
    
    }
}
    
extension SecondTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArr.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCV.dequeueReusableCell(withReuseIdentifier: "productCVCell", for: indexPath) as! ProductCollectionViewCell
        
        let item = itemArr[indexPath.item]
        
        //url에 정확한 이미지 url 주소를 넣는다.
        let url = URL(string: "\(item!.itemPhotoURL)")
        var image : UIImage?
        //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
        //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
        DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            cell.cvProductImg.image = UIImage(data: data!)
            }
        }

        
        
        //cell.cvProductImg.image = UIImage(named: "productImgSample.png")
        cell.cvProductTitle.text = item?.itemName
        print("itemName>>>>\(item?.itemName)")
        cell.cvStarPoint.image = UIImage(named: "starPoint.png")
        cell.cvCommentCount.text = "(\(String(item!.numOfReview)))"
        cell.cvReview.text = item?.newReview
        
        return cell
    }
    
}

extension SecondTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.selectedCVCell(indexPath.item)
            print("\(indexPath.item + 1) 번째 셀")
            
            let detailView = detailViewController()
            detailView.receiveIndexPath(indexPath.item)
        }
    }
}
