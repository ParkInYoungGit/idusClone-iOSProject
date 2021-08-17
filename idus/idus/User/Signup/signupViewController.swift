//
//  signupViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/17.
//

import UIKit

class signupViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordCheck: UITextField!
    @IBOutlet weak var tfTel: UITextField!
    @IBOutlet weak var tfRecommend: UITextField!
    
    @IBOutlet weak var signUpBottomView: UIView!
    
    
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
    }
    
    @IBAction func firstAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func secondAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    @IBAction func thirdAgree(_ sender: UIButton) {
        sender.isSelected.toggle()
    }

    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
