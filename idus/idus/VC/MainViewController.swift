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
       
       var dataSource = [(menuTitle: "투데이", vc: viewController(.red)), (menuTitle: "실시간", vc: viewController(.blue)), (menuTitle: "NEW", vc: viewController(.yellow))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
                menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        tabbarConfigure()
        navigationSetting()
        menuViewController.reloadData()
        contentViewController.reloadData()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self // <- set menu data source
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
        }
    }

}
//메뉴 데이터소스
extension MainViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return 100
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }
}
//컨텐트 데이터소스
extension MainViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].vc
    }
}
