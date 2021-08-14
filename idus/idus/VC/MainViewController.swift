//
//  MainViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/14.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarConfigure()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 탭바 설정
    func tabbarConfigure(){
        tabBarController?.tabBar.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        tabBarController?.tabBar.unselectedItemTintColor = UIColor.lightGray
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
