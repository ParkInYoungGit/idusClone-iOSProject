//
//  loginViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import UIKit

class loginViewController: UIViewController {
    @IBOutlet weak var btnLogin: UIButton!
    lazy var dataManager: LoginDataManager = LoginDataManager()
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnLogin.layer.cornerRadius = 10
        btnLogin.layer.borderWidth = 2
        btnLogin.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        tfEmail.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        tfPassword.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        guard let email = tfEmail.text?.trim, email.isExists else {
            self.presentAlert(title: "아이디를 입력해주세요")
            return
        }
        
        // Password validation
        guard let password = tfPassword.text, password.isExists else {
            self.presentAlert(title: "비밀번호를 입력해주세요")
            return
        }
        
        // Requst Sign In
        self.dismissKeyboard()
        let input = LoginReq(email: email, password: password)
        dataManager.postLogIn(input, delegate: self)
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
extension loginViewController {
        func didSuccessLogIn(_ result: Result) {
            //self.presentAlert(title: "로그인에 성공하였습니다", message: result.jwt)
            let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mypageVC = splashStoryboard.instantiateViewController(identifier: "mainpage")
            self.changeRootViewController(mypageVC)
        }
        
        func failedToLogin(message: String) {
            self.presentAlert(title: message)
        }
}
