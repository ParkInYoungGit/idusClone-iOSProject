//
//  buyViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit
var detail: detailResult?

class buyViewController: UIViewController {
var finishPrice = 0
var useridx = 0
var addidx = 0
var count = 0
var itemidx: Int? = 0
var optionidx = 0
    
    var dataManager = orderInfoDataManager()
    var dataManager2 = orderDataManager()
    var data: [orderInfoResult] = [] {
        didSet {
            tableView.reloadData()
        }
    }
   
    var imgArr = ["pay1.png","pay2.png","pay3.png","pay4.png","pay5.png","pay6.png"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.getOrderInfo(delegate: self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "buyDataTableViewCell", bundle: nil), forCellReuseIdentifier: "buyInfoCell")
        tableView.register(UINib(nibName: "payTableViewCell", bundle: nil), forCellReuseIdentifier: "payCell")
        tableView.register(UINib(nibName: "priceTableViewCell", bundle: nil), forCellReuseIdentifier: "priceCell")
        tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        //self.tabBarController?.tabBar.isHidden = true
        var image = UIImage(named: "back29.png")
        image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        let backBtn = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem = backBtn
        
       
    }
    
    func didSuccessOrderInfo(_ result: [orderInfoResult]) {
        data = result
        print("userInfo>>>>>>>>>>>>>>>>>>\(data)")
        addidx = data[0].addressIdx!
        tableView.reloadData()
    }
    func failedToRequestOrderInfo(message: String) {
        //self.presentAlert(title: message)
        
    }
    @objc func back() {
           self.navigationController?.popViewController(animated: true)
       }
    func receiveItem(data : detailResult?, price : Int, quantity: Int) {
        finishPrice = price
        detail = data
        itemidx = detail?.itemIdx
        count = quantity
        print(">>>>>>>>>>>>>>>>>\(data)")
    }
    
    
    
    @IBAction func btnBuy(_ sender: Any) {
        useridx = Constant.shared.idx
        switch itemidx {
        case 1:
            optionidx = 8
        case 2:
            optionidx = 16
        case 3:
            optionidx = 23
        case 4:
            optionidx = 4
        case 5:
            optionidx = 31
        default:
            optionidx = 1
        }
        
        
        let input = orderReq(userIdx: useridx, addressIdx: addidx, price: finishPrice, purchaseQuantity: count, itemOpt1Idx: optionidx)
        print("inputinputinputinputinput\(input)")
        dataManager2.postOrder(input, delegate: self)
    }
    
    func didSuccessOrder(_ result: orderRes) {
        
let orderAlert = UIAlertController(title: "??????", message: "??????????????? ????????? ?????? ???????????????.", preferredStyle: UIAlertController.Style.alert)
let onAction = UIAlertAction(title: "??????", style: UIAlertAction.Style.default, handler: {ACTION in
    let splashStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let mypageVC = splashStoryboard.instantiateViewController(identifier: "mainpage")
    self.changeRootViewController(mypageVC)
})
    orderAlert.addAction(onAction)
    present(orderAlert, animated: true, completion: nil)
        
        
    }
    func failedToOrder(message: String) {
        self.presentAlert(title: message)
    }
    

    
}

extension buyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        
        return tableView.rowHeight
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1{
            return imgArr.count
        } else if section == 2{
            return 1
        }
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        //let name = UserDefaults.standard.string(forKey: "nickName")
        //let phone = UserDefaults.standard.string(forKey: "phone")
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "buyCell", for: indexPath)
                cell.textLabel?.text = "????????????"
                    if indexPath.row < data.count {
                        if let name2 = data[indexPath.row].userName, let phone2 = data[indexPath.row].userPhone {
                        print("????????????!!\(indexPath.row)")
                        
                        print("name2!!\(name2)")
                        print("???????????????!!\(data[indexPath.row].userName)")
                        
                        cell.detailTextLabel?.text = "\(name2)(\(phone2))"
                        }
                    }
            return cell
            
            case 1 : let cell = tableView.dequeueReusableCell(withIdentifier: "buyInfoCell", for: indexPath) as! buyDataTableViewCell
                if indexPath.row < data.count {
                    //var item = data[indexPath.row]
                    cell.recieveName.text = data[indexPath.row].recipientName
                    cell.address.text = data[indexPath.row].address
                    cell.tfPhone.text = data[indexPath.row].recipientPhone
                
                }
                cell.selectionStyle = .none

              //  cell.tfPhone.text = "\(item?.userPhone)"
//              cell.address.text = data[0].address
//              cell.recieveName.text = data[0].userName
            return cell
            default: UITableViewCell()
            }
        }
        
        if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "payCell", for: indexPath) as! payTableViewCell
                cell.payImg.image = UIImage(named: imgArr[indexPath.row])
                cell.selectionStyle = .none
                return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath) as! priceTableViewCell
            
            
            if let price1 = detail?.reducedPrice {
                if let price = numberFormatter.string(from: NSNumber(value: (finishPrice))) {
            cell.lblPrice.text = "\(price)???"
                }
            }
            
            if let delivery = detail?.deliveryCharge {
                if let delive = numberFormatter.string(from: NSNumber(value: delivery)) {
                cell.lblDelivery.text = "\(delive)???"
                }
            }
            
            if let delivery = detail?.deliveryCharge, let price = detail?.reducedPrice {
                let total = delivery + finishPrice
                    if let sum = numberFormatter.string(from: NSNumber(value: total)) {
                cell.lblTotalPrice.text = "\(sum)???"
                }
            }
            
            
            
            return cell
        
        }
        
        return UITableViewCell()
    }


}

extension buyViewController {
    

}
