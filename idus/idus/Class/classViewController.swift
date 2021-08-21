//
//  classViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/22.
//

import UIKit
import PagingKit

class classViewController: UIViewController {
    
    var menuViewController2: PagingMenuViewController!
    var contentViewController2: PagingContentViewController!
    
    var dataSource = [(menu: String, content: UIViewController)](){
        didSet{
            menuViewController2.reloadData()
            contentViewController2!.reloadData()
        }
    }
    
    lazy var firstLoad: (()-> Void)? = {[weak self, menuViewController2, contentViewController2] in
        menuViewController2?.reloadData()
        contentViewController2?.reloadData()
        self?.firstLoad = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController2.register(nib: UINib(nibName: "MenuCell2", bundle: nil), forCellWithReuseIdentifier: "MenuCell2")
        menuViewController2.registerFocusView(view: UnderlineFocusView())
        dataSource = makeDataSource()
        menuViewController2.reloadData()
        contentViewController2.reloadData()
        menuViewController2.cellAlignment = .center
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
                menuViewController2 = vc
                menuViewController2.dataSource = self
                menuViewController2.delegate = self
            } else if let vc = segue.destination as? PagingContentViewController {
                contentViewController2 = vc
                contentViewController2.dataSource = self
                contentViewController2.delegate = self
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
        let myMenuArray = ["온라인","오프라인"]
        
        return myMenuArray.map {
            let title = $0
            
            switch title {
            case "온라인":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "today") as! todayViewController
                return (menu: title, content: vc)
            case "오프라인":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "today") as! todayViewController
                return (menu: title, content: vc)
            default:
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "today") as! todayViewController
                return (menu: title, content: vc)
                
                }
            }
        }
}

//메뉴 데이터소스
extension classViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 200
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell2", for: index) as! MenuCell2
        //let cell = viewController.dequeueReusableCell(withReuseIdentifier: "TitleLabelMenu", for: index) as! TitleLabelMenuViewCell
        cell.lblTitle.text = dataSource[index].menu
        return cell
    }
}
//컨텐트 데이터소스
extension classViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension classViewController: PagingMenuViewControllerDelegate {
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController2.scroll(to: page, animated: true)
    }
}

extension classViewController: PagingContentViewControllerDelegate {
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController2.scroll(index: index, percent: percent, animated: false)
    }
}
