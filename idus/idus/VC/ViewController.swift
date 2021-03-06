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
import NaverThirdPartyLogin

class ViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    @IBOutlet weak var idusImage: UIImageView!
    @IBOutlet weak var kakaobtn: UIButton!
    @IBOutlet weak var naverbtn: UIButton!
    @IBOutlet weak var userbtn: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 2.0
    var numImage = 0
    var count = 0
    var timer: Timer?
    var imagName = ["signUp.jpeg","mainImage.jpg"]
 
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    override func viewDidLoad() {
        super.viewDidLoad()
        radiusSetting()
        loginInstance?.delegate = self
        loginInstance?.requestDeleteToken()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "yyyy-MM-dd EEE a hh:mm" //년도-월-일 요일 (오전/오후) 시간:분
        
        count += 1
        if count >= imagName.count {
            count = 0
      }
        backGroundImage(number: count)
        print(count)
    }
    
    func backGroundImage(number: Int){
        bgImage.image = UIImage(named: imagName[number])
        
        UIView.transition(with: self.bgImage,
                           duration: 1,
                           options: [.allowAnimatedContent, .transitionCrossDissolve],
                           animations: { self.bgImage.image = UIImage(named: self.imagName[number]) },
                           completion: nil)
    
    }

    @IBAction func otherLogin(_ sender: UIButton) {
        let actionR = UIAlertAction(title: "페이스북", style: .default) { action in
            self.view.backgroundColor = .red
        }
        let actionG = UIAlertAction(title: "트위터", style: .default) { action in
            self.view.backgroundColor = .green
        }
        let actionB = UIAlertAction(title: "이메일", style: .default) { action in
            let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mypageVC = splashStoryboard.instantiateViewController(identifier: "signup")
            self.changeRootViewController(mypageVC)
        }
       
        self.presentAlert(
            title: "다른방법으로 가입하기",
            preferredStyle: .actionSheet,
            with: actionR, actionG, actionB
        )
    }
        
    
    
    @IBAction func noLogin(_ sender: Any) {
        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mypageVC = splashStoryboard.instantiateViewController(identifier: "mainpage")
        self.changeRootViewController(mypageVC)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.timer != nil {
        self.timer?.invalidate()
        }
    }
    
    func radiusSetting(){
        idusImage.layer.cornerRadius = 30
        kakaobtn.layer.cornerRadius = 30
        naverbtn.layer.cornerRadius = 30
        userbtn.layer.cornerRadius = 20
        userbtn.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userbtn.layer.borderWidth = 2
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
                
                UserDefaults.standard.set(nickName, forKey: "nickName")
                
                print("카카오 정보 가져오기\(gender)+\(nickName)+\(email)")
                    

        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mypageVC = splashStoryboard.instantiateViewController(identifier: "mainpage")
        self.changeRootViewController(mypageVC)
                
                
            }
        }
    }


//MARK: naver 로그인
    
    @IBAction func naverLogin(_ sender: Any) {
        loginInstance?.requestThirdPartyLogin()
    }
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success login")
        getInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        loginInstance?.accessToken
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("log out")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error = \(error.localizedDescription)")
    }

    func getInfo() {
      guard let isValidAccessToken = loginInstance?.isValidAccessTokenExpireTimeNow() else { return }
      
      if !isValidAccessToken {
        return
      }
      
      guard let tokenType = loginInstance?.tokenType else { return }
      guard let accessToken = loginInstance?.accessToken else { return }
        
      let urlStr = "https://openapi.naver.com/v1/nid/me"
      let url = URL(string: urlStr)!
      
      let authorization = "\(tokenType) \(accessToken)"
      
      let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
      
      req.responseJSON { response in
        guard let result = response.value as? [String: Any] else { return }
        guard let object = result["response"] as? [String: Any] else { return }
        guard let name = object["name"] as? String else { return }
        guard let email = object["email"] as? String else { return }
        guard let id = object["id"] as? String else {return}
        
        UserDefaults.standard.set(name, forKey: "nickName")
        
        let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mypageVC = splashStoryboard.instantiateViewController(identifier: "mainpage")
        self.changeRootViewController(mypageVC)
                
        print(email)

      }
    }





}
