//
//  newViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit

class newViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var itemArr: [todayResult?] = []
    
    var dataManager = newDataManager()
    @IBOutlet weak var collectionVew: UICollectionView!
    var ImgArr = [""]
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionVew.delegate = self
        collectionVew.dataSource = self
        dataManager.getProduct(delegate: self)
        collectionVew.collectionViewLayout = createCompositionalLayout()
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        itemArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell2", for: indexPath) as! MyCollectionViewCell2
        
        let item = itemArr[indexPath.item]
        
        let url = URL(string: "\(item!.itemPhotoURL)")
        DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            cell.newImg.image = UIImage(data: data!)
            cell.newImg.contentMode = .scaleAspectFill
            }
        }
        
        cell.newItemName.text = item?.itemName
        cell.newItemReview.text = item?.newReview
        
        return cell
    }
    
    
    func didSuccessProduct(data: todayRes) {
        print("result확인>>>\(data)")
            //items.itemNameArr.append(data[i]!.itemName)
        itemArr = data.result
        collectionVew.reloadData()
    }
    func failedToRequest(message: String) {
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    fileprivate func createCompositionalLayout() -> UICollectionViewLayout {
            
            // 컴포지셔널 레이아웃 생성
            // 만들게되면 튜플(키: 값, 키: 값) 의 묶음으로 들어옴 반환하는것은 NSCollectionLayoutSecsion 콜렉션 레이아웃 섹션을 반환해야함
            let layout = UICollectionViewCompositionalLayout {
                    (sectionIndex: Int, layoutEnviromonet: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
                
                // 아이템에 대한 사이즈 - absolute는 고정값, estimated는 추측, fraction 퍼센트(비율)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalWidth(0.7))
                
                // 위에서 만든 아이템사이즈로 아이템 만들기
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
               
                // 아이템 간격 설정
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing:2)
                    
                // 그룹사이즈
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: itemSize.heightDimension)
                    
                // 그룹사이즈로 그룹 만들기
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                    
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
