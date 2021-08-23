//
//  buyViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/23.
//

import UIKit

class buyViewController: UIViewController {

    var detail: detailResult?
    var imgArr = ["pay1.png","pay2.png","pay3.png","pay4.png","pay5.png",]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "buyDataTableViewCell", bundle: nil), forCellReuseIdentifier: "buyInfoCell")
        tableView.register(UINib(nibName: "payTableViewCell", bundle: nil), forCellReuseIdentifier: "payCell")
        tableView.register(UINib(nibName: "priceTableViewCell", bundle: nil), forCellReuseIdentifier: "priceCell")
        tableView.rowHeight = UITableView.automaticDimension
        // Do any additional setup after loading the view.
        self.tabBarController?.tabBar.isHidden = true
    }

}

extension buyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row{
//        case 0 :
//            return tableView.rowHeight
//        case 1 :
//            return 200
//        case 2:
//            return tableView.rowHeight
//        case 3:
//            return 140
//        default :
//            return tableView.rowHeight
//        }
        
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
        let name = UserDefaults.standard.string(forKey: "nickName")
        let phone = UserDefaults.standard.string(forKey: "phone")
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: let cell = tableView.dequeueReusableCell(withIdentifier: "buyCell", for: indexPath)
            cell.textLabel?.text = "주문고객"
            if let name2 = name, let phone2 = phone {
                cell.detailTextLabel?.text = "\(name2)(\(phone2))"
            }
            return cell
            
            case 1 : let cell = tableView.dequeueReusableCell(withIdentifier: "buyInfoCell", for: indexPath) as! buyDataTableViewCell
                cell.selectionStyle = .none
                if let phone2 = phone {
                    cell.tfPhone.text = "\(phone2)"
                }
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
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                if let price = numberFormatter.string(from: NSNumber(value: (price1))) {
            cell.lblPrice.text = "\(price)원"
                }
            }
            
            if let delivery = detail?.deliveryCharge {
                cell.lblDelivery.text = "\(delivery)원"
            }
            
            if let delivery = detail?.deliveryCharge, let price = detail?.reducedPrice {
                cell.lblTotalPrice.text = "\(delivery+price)원"
                print("테스트>>>>>>>>\(delivery+price)")
            }
            
            
            return cell
        
        }
        
        return UITableViewCell()
    }


}

extension buyViewController {
    func receiveItem(data : detailResult?) {
        detail = data
        print(">>>>>>>>>>>>>>>>>\(data)")
    }
}
