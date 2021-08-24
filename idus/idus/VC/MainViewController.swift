//
//  MainViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/14.
//

import UIKit
import PagingKit

class MainViewController: UIViewController{

    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    static var viewController: (UIColor) -> UIViewController = { (color) in
      let vc = UIViewController()
       vc.view.backgroundColor = color
       return vc
   }
       
    var dataSource = [(menu: String, content: UIViewController)](){
        didSet{
            menuViewController.reloadData()
            contentViewController!.reloadData()
        }
    }
    
    lazy var firstLoad: (()-> Void)? = {[weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData()
        self?.firstLoad = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.shadowImage = UIImage()
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(view: UnderlineFocusView())
        tabbarConfigure()
        navigationSetting()
        dataSource = makeDataSource()
        menuViewController.reloadData()
        contentViewController.reloadData()
        menuViewController.cellAlignment = .center
        
    }
    
    // MARK: - 탭바 설정
    func tabbarConfigure(){
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.lightGray
    }
    
    func navigationSetting(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "mainidus.png")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationController?.navigationBar.barTintColor = UIColor.white
    }

    
    // MARK: - 커스텀탭바 설정들
    
    fileprivate func makeDataSource() -> [(menu: String, content: UIViewController)]{
        let myMenuArray = ["투데이","실시간","NEW"]
        
        return myMenuArray.map {
            let title = $0
            
            switch title {
            case "투데이":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "today") as! todayViewController
                return (menu: title, content: vc)
            case "실시간":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "now") as! nowViewController
                return (menu: title, content: vc)
            case "NEW":
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "new") as! newViewController
                return (menu: title, content: vc)
            default:
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "today") as! todayViewController
                return (menu: title, content: vc)
                
                }
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self // <- set menu data source
            menuViewController.delegate = self // <- set menu delegate
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }

}
    //메뉴 데이터소스
    extension MainViewController: PagingMenuViewControllerDataSource {
        func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
            return dataSource.count
        }
        
        func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
            return 135
        }
        
        func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
            let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
            //let cell = viewController.dequeueReusableCell(withReuseIdentifier: "TitleLabelMenu", for: index) as! TitleLabelMenuViewCell
            cell.titleLabel.text = dataSource[index].menu
            cell.titleLabel.textColor = .lightGray
            return cell
        }
    }
    //컨텐트 데이터소스
    extension MainViewController: PagingContentViewControllerDataSource {
        func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
            return dataSource.count
        }
        
        func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
            return dataSource[index].content
        }
    }

    extension MainViewController: PagingMenuViewControllerDelegate {
        func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
            contentViewController.scroll(to: page, animated: true)
        }
    }

    extension MainViewController: PagingContentViewControllerDelegate {
        func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
            menuViewController.scroll(index: index, percent: percent, animated: false)
        }
    }
