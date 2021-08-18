//
//  signupViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import UIKit

class signupViewController: UIViewController {
    lazy var dataManager: SignupDataManager = SignupDataManager()
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordCheck: UITextField!
    @IBOutlet weak var tfTel: UITextField!
    @IBOutlet weak var tfRecommend: UITextField!
    @IBOutlet weak var allagree: UIButton!
    @IBOutlet weak var firstagree: UIButton!
    @IBOutlet weak var secondagree: UIButton!
    @IBOutlet weak var thirdagree: UIButton!
    @IBOutlet weak var signUpBottomView: UIView!
    
    var checkBoxArr = [firstAgree,secondAgree,thirdAgree,allAgree]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpBottomView.layer.borderWidth = 1
        signUpBottomView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textfieldSetting()
        
        
    }
    func textfieldSetting(){
        tfName.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        tfEmail.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        tfPassword.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        tfPasswordCheck.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        tfTel.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
        tfRecommend.layer.addBorder([.bottom], color: UIColor.white, width: 1.0)
    }
    
    @IBAction func allAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
        allCheck()
    }
    
    @IBAction func firstAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
        check()
    }
    @IBAction func secondAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
        check()
    }
    @IBAction func thirdAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
        check()
    }
    
    func check(){
        
        if firstagree.isSelected && secondagree.isSelected && thirdagree.isSelected {
            allagree.isSelected.toggle()
        } else {
            allagree.isSelected = false
        }
    }
    
    func allCheck(){
        if allagree.isSelected{
            allagree.isSelected = true
            firstagree.isSelected = true
            secondagree.isSelected = true
            thirdagree.isSelected = true
        } else {
            allagree.isSelected = false
            firstagree.isSelected = false
            secondagree.isSelected = false
            thirdagree.isSelected = false
        }
       
    }
    

    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnSignUp(_ sender: Any) {
        guard let userName = tfName.text, userName.isExists else{
            self.presentAlert(title: "이름을 입력해주세요")
            return
        }
        guard let password = tfPassword.text, password.isExists else{
            self.presentAlert(title: "비밀번호를 입력해주세요")
            return
        }
        guard let email = tfEmail.text, email.isExists else{
            self.presentAlert(title: "이메일을 입력해주세요")
            return
        }
        guard let phone = tfTel.text, phone.isExists else{
            self.presentAlert(title: "전화번호를 입력해주세요")
            return
        }
        guard let password = tfPassword.text, let passwordCheck = tfPasswordCheck.text, password == passwordCheck else {
            self.presentAlert(title: "비밀번호가 일치하지 않습니다.")
                    return
                }
       if firstagree.isSelected && secondagree.isSelected {
       } else {
            self.presentAlert(title: "동의사항을 체크해주세요.")
            return
        }
        
        self.dismissKeyboard()
        let input = SignupReq(userName: userName, password: password, email: email, phone: phone)
        dataManager.postSignUp(input, delegate: self)
    }
}
    
    extension signupViewController {
        func didSuccessSignUp(_ result: Result) {
            let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mypageVC = splashStoryboard.instantiateViewController(identifier: "loginPage")
            self.changeRootViewController(mypageVC)
        }
        func failedToRequest(message: String) {
            self.presentAlert(title: message)
        }
    }




extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}
