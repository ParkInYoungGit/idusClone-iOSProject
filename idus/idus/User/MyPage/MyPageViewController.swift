//
//  MyPageViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/14.
//

import UIKit

class MyPageViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    var dataManager = MyPageDataManager()
    var data: myPageResult?
    
    @IBOutlet weak var lblName: UILabel!
    var userName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //userName = UserDefaults.standard.string(forKey: "nickName")!
        //lblName.text = userName
        profileImage.image = UIImage(named: "profileImage.png")
        profileImage.layer.cornerRadius = 10

        let idx = 5
        dataManager.getMyPage(idx, delegate: self)
        
        // Do any additional setup after loading the view.
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
extension MyPageViewController {
    func didSuccessMypage(_ result: myPageResult) {
        data = result
        lblName.text = data?.userName
        UserDefaults.standard.set(data?.userName, forKey: "nickName")
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
