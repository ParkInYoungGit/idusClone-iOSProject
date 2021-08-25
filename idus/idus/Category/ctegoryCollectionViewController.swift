//
//  ctegoryCollectionViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit

class ctegoryCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var ImgArr = ["category1.png","category2.png","category3.png","category4.png","category5.png","category6.png","category7.png","category8.png","category9.png","category10.png","category11.png","category12.png","category13.png","category14.png","category15.png","category16.png","category17.png","category18.png","category19.png","category20.png","category21.png",]
    var cateArr = ["수제청","와인","채소","요거트","떡,베이커리","반찬","홈웨어","키링","지갑","이너웨어","악세서리","가방","수제화","홈슈즈","파우치","시트","악세서리","반지","팔찌","자동차키","꽃"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.collectionViewLayout = createCompositionalLayout()
    }

}

extension ctegoryCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ImgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //클래스명 string으로가져오기 : String(describing: Subject)
        // let cellId = String(describing: myCollectionViewCell.self)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        cell.categoryImg.image = UIImage(named: ImgArr[indexPath.item])
        cell.lblCategory.text = cateArr[indexPath.item]
        return cell
    }
    
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
            
            // 컴포지셔널 레이아웃 생성
            // 만들게되면 튜플(키: 값, 키: 값) 의 묶음으로 들어옴 반환하는것은 NSCollectionLayoutSecsion 콜렉션 레이아웃 섹션을 반환해야함
            let layout = UICollectionViewCompositionalLayout {
                    (sectionIndex: Int, layoutEnviromonet: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                
                // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트(비율)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalWidth(0.3))
                
                // 위에서 만든 아이템사이즈로 아이템 만들기
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
               
                // 아이템 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing:2)
                    
                // 그룹사이즈
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
                    
                // 그룹사이즈로 그룹 만들기
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                    
                // 그룹으로 섹션만들기
                let section = NSCollectionLayoutSection(group: group)
                
                // 오른쪽으로 스크롤
                // section.orthogonalScrollingBehavior = .continuous
                
                // 그룹페이징
                //section.orthogonalScrollingBehavior = .groupPaging
                    
                // 아이템모여서 그룹 그룹이 모여서 섹션
                // 섹션에 대한 간격
                section.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
                
                return section
            }
            return layout
        }
    
}
