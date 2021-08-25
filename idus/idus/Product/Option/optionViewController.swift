//
//  optionViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/25.
//

import UIKit
import PanModal
class optionViewController: UIViewController {
    var item: [optionResult] = []
 //   var dataManager = optionDataManager ()
    @IBOutlet weak var tfCount: UITextField!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deliveryP: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnBuy: UIButton!
    var totalP = 0
    var productPrice = 0
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCart.layer.borderWidth = 0.3
        btnCart.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        btnCart.layer.cornerRadius = 2
        btnBuy.layer.borderWidth = 0.3
        btnBuy.layer.borderColor = #colorLiteral(red: 1, green: 0.4337799549, blue: 0, alpha: 1)
        btnBuy.layer.cornerRadius = 2
        tfCount.text = "\(count)"
        
//        if let productNum = detail?.itemIdx {
//            dataManager.getOption(productNum: productNum, delegate: self)
//        }
        

        // Do any additional setup after loading the view.
    }
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
    @IBAction func btnPlus(_ sender: Any) {
        count += 1
        productPrice = detail!.reducedPrice * count
        totalP = productPrice + detail!.deliveryCharge
        
        tfCount.text = "\(count)"
        lblPrice.text = "\(numberFormatter(number: productPrice))원"
        totalPrice.text = "\(numberFormatter(number: totalP))원"
        
    }
    @IBAction func btnMinus(_ sender: Any) {
        count -= 1
        tfCount.text = "\(count)"
        if count < 1 {
            count = 1
            tfCount.text = "\(count)"
        }
        productPrice = detail!.reducedPrice * count
        totalP = productPrice + detail!.deliveryCharge
        lblPrice.text = "\(numberFormatter(number: productPrice))원"
        totalPrice.text = "\(numberFormatter(number: totalP))원"
    }
    
    func receiveItem(data : detailResult?) {
        detail = data
        print("optionTableView>>>>>>>>>>>>>>>>>\(data)")
        //print("\(item.count)")
    }
    
//
//    func didSuccessOption(data : optionRes){
//        item = data.result
//        print("optionitemTableView>>>>>>>>>>>>>>>>>\(item)")
//        viewWillAppear(true)
//    }
//
//    func failedToRequest(message: String) {
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblItemName.text = detail?.name
        if let delivery = detail?.deliveryCharge {
            deliveryP.text = "\(numberFormatter(number: delivery))원"
        }
        if let price = detail?.reducedPrice {
            lblPrice.text = "\(numberFormatter(number: price))원"
        }
        
        totalP = (detail!.deliveryCharge) + (detail!.reducedPrice)
        totalPrice.text = "\(numberFormatter(number: totalP))원"
        
        
        productPrice = detail!.reducedPrice
        }
    
    @IBAction func btnBuy(_ sender: UIButton) {
//        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "buyVC")as? buyViewController else { return }
//            self.navigationController?.pushViewController(vc, animated: true)
        
            let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let mypageVC = splashStoryboard.instantiateViewController(identifier: "buyVC") as! buyViewController
            self.changeRootViewController(mypageVC)
        
        
            mypageVC.receiveItem(data : detail)
            print("버튼테스트")
        }
    
    }


extension optionViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return nil
       }
       var shortFormHeight: PanModalHeight {
         return .contentHeight(230)
       }
       var longFormHeight: PanModalHeight {
         return .maxHeightWithTopInset(300)
       }
       var anchorModalToLongForm: Bool {
         return true
       }
     }
