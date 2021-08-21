//
//  detailViewTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/21.
//

import UIKit

class detailViewTableViewCell: UITableViewCell {

    @IBOutlet weak var smallImageCollectionView: UICollectionView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    var productImgArr = ["detailProduct","detailProduct2","detailProduct3","detailProduct4","detailProduct5","detailProduct6","detailProduct7"]
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.register(UINib(nibName: "imageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        imageCollectionView.collectionViewLayout = createCompositionalLayout()
        
        smallImageCollectionView.delegate = self
        smallImageCollectionView.dataSource = self
        smallImageCollectionView.register(UINib(nibName: "smallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "smallImage")
        smallImageCollectionView.collectionViewLayout = createCompositionalLayout2()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension detailViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == imageCollectionView {
            let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCollectionViewCell
            cell.detailImage.image = UIImage(named: productImgArr[indexPath.row])
            cell.detailImage.contentMode = .scaleAspectFit
                return cell
            } else {
                let cell = smallImageCollectionView.dequeueReusableCell(withReuseIdentifier: "smallImage", for: indexPath) as! smallCollectionViewCell
                cell.smallImage.image = UIImage(named: productImgArr[indexPath.row])
                cell.smallImage.contentMode = .scaleAspectFit
                return cell
            }
    
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        imageCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        if self.smallImageCollectionView.allowsMultipleSelection == false {
            let cell = smallImageCollectionView.cellForItem(at: indexPath)
                if cell?.isSelected == true{
                    cell?.layer.borderWidth = 1
                    cell!.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                }
        }
        print("Cell \(indexPath.row + 1) clicked")
    }
    
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        <#code#>
//    }

    
    
    // 컴포지셔널 레이아웃 설정
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
        
        // 컴포지셔널 레이아웃 생성
        // 만들게되면 튜플(키: 값, 키: 값) 의 묶음으로 들어옴 반환하는것은 NSCollectionLayoutSecsion 콜렉션 레이아웃 섹션을 반환해야함
        let layout = UICollectionViewCompositionalLayout {
                (sectionIndex: Int, layoutEnviromonet: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트(비율)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
            
            // 위에서 만든 아이템사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
            // 아이템 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing:2)
                
            // 그룹사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
                
            // 그룹사이즈로 그룹 만들기
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
                
            // 그룹으로 섹션만들기
            let section = NSCollectionLayoutSection(group: group)
            
            // 오른쪽으로 스크롤
            // section.orthogonalScrollingBehavior = .continuous
            
            // 그룹페이징
            section.orthogonalScrollingBehavior = .groupPaging
                
            // 아이템모여서 그룹 그룹이 모여서 섹션
            // 섹션에 대한 간격
            section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
            
            return section
        }
        return layout
    }
    
    
    fileprivate func createCompositionalLayout2() -> UICollectionViewLayout {
        
        // 컴포지셔널 레이아웃 생성
        // 만들게되면 튜플(키: 값, 키: 값) 의 묶음으로 들어옴 반환하는것은 NSCollectionLayoutSecsion 콜렉션 레이아웃 섹션을 반환해야함
        let layout = UICollectionViewCompositionalLayout {
                (sectionIndex: Int, layoutEnviromonet: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트(비율)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.13))
            
            // 위에서 만든 아이템사이즈로 아이템 만들기
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
            // 아이템 간격 설정
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
            // 그룹사이즈
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.13), heightDimension: itemSize.heightDimension)
                
            // 그룹사이즈로 그룹 만들기
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
            
                
            // 그룹으로 섹션만들기
            let section = NSCollectionLayoutSection(group: group)
            // add leading and trailing insets to the section so groups are aligned to the center
         
            
            // 오른쪽으로 스크롤
            section.orthogonalScrollingBehavior = .continuous
            
            // 그룹페이징
            //section.orthogonalScrollingBehavior = .groupPaging
                
            // 아이템모여서 그룹 그룹이 모여서 섹션
            // 섹션에 대한 간격
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            return section
        }
        return layout
    }
    
}
