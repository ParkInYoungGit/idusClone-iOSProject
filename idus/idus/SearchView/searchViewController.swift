//
//  searchViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/22.
//

import UIKit

class searchViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mypageVC = splashStoryboard.instantiateViewController(identifier: "searchClicked")
        self.changeRootViewController2(mypageVC)
        // Do any additional setup after loading the view.
    }
    
    func changeRootViewController2(_ viewControllerToPresent: UIViewController) {
        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mypageVC = splashStoryboard.instantiateViewController(identifier: "searchClicked")
        self.changeRootViewController(mypageVC)
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
