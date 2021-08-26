//
//  categoryViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit
import PagingKit

class categoryViewController: UIViewController {
    
    var menuViewController3: PagingMenuViewController!
    var contentViewController3: PagingContentViewController!
    
    var dataSource = [(menu: String, content: UIViewController)](){
        didSet{
            menuViewController3.reloadData()
            contentViewController3!.reloadData()
        }
    }
    
    lazy var firstLoad: (()-> Void)? = {[weak self, menuViewController3, contentViewController3] in
        menuViewController3?.reloadData()
        contentViewController3?.reloadData()
        self?.firstLoad = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController3.register(nib: UINib(nibName: "MenuCell3", bundle: nil), forCellWithReuseIdentifier: "MenuCell3")
        menuViewController3.registerFocusView(view: UnderlineFocusView())
        dataSource = makeDataSource()
        menuViewController3.reloadData()
        contentViewController3.reloadData()
        menuViewController3.cellAlignment = .center
        navigationSetting()
        // Do any additional setup after loading the view.
    }
    
    func navigationSetting(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "mainidus.png")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = UIColor.white
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? PagingMenuViewController {
                menuViewController3 = vc
                menuViewController3.dataSource = self
                menuViewController3.delegate = self
            } else if let vc = segue.destination as? PagingContentViewController {
                contentViewController3 = vc
                contentViewController3.dataSource = self
                contentViewController3.delegate = self
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)]{
        let myMenuArray = ["작품","클래스"]
        
        return myMenuArray.map {
            let title = $0
            
            switch title {
            case "작품":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "categoryCV") as!
                ctegoryCollectionViewController
                return (menu: title, content: vc)
            case "클래스":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "categoryClass") as! categoryClassViewController
                return (menu: title, content: vc)
            default:
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "today") as! todayViewController
                return (menu: title, content: vc)
                
                }
            }
        }
}

//메뉴 데이터소스
extension categoryViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 200
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell3", for: index) as! MenuCell3
        //let cell = viewController.dequeueReusableCell(withReuseIdentifier: "TitleLabelMenu", for: index) as! TitleLabelMenuViewCell
        cell.lblMenuCell3.text = dataSource[index].menu
        return cell
    }
}
//컨텐트 데이터소스
extension categoryViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension categoryViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController3.scroll(to: page, animated: true)
    }
}

extension categoryViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController3.scroll(index: index, percent: percent, animated: false)
    }
}
