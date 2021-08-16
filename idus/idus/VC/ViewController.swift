//
//  ViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/14.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import Alamofire


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func otherLogin(_ sender: UIButton) {
//        let actionR = UIAlertAction(title:"페이스북", style: .default) { action in
//        }
//        self.presentAlert(title: "다른 방법으로 가입하기", with: actionR)
        
    }
    
    //MARK: - kakao로그인
    @IBAction func kakaoLogin(_ sender: Any) {
       UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
          if let error = error {
              print(error)
          }
          else {
              print("loginWithKakaoAccount() success.")

              //do something
               _ = oauthToken
            self.setUserInfo()
          }
      }
    }
    
    
    func setUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")

                //do something
                _ = user
                let gender = user?.kakaoAccount?.gender
                let nickName = user?.kakaoAccount?.profile?.nickname
                let email = user?.kakaoAccount?.email
                
                print("카카오 정보 가져오기\(gender)+\(nickName)+\(email)")
            }
        }
    }
}

