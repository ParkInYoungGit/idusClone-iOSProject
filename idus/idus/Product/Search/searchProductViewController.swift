//
//  searchViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit

class searchProductViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mypageVC = splashStoryboard.instantiateViewController(identifier: "mainpage")
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
