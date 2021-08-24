//
//  detailViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/21.
//

import UIKit
import PanModal

var productNum = 0
class detailViewController: UIViewController {
    

    var dataManager = detailViewDataManager()
    var photoManager = detailPhotoDataManager()
    var reviewdataManager = reviewDataManager()
    var detail : detailResult? {
        didSet {
            detailTableView.reloadData()
        }
    }
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbar.layer.cornerRadius = 40
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: "detailViewTableViewCell", bundle: nil), forCellReuseIdentifier: "detailTableCell")
        detailTableView.register(UINib(nibName: "itemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        detailTableView.register(UINib(nibName: "contentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentCell")
        detailTableView.register(UINib(nibName: "imageTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        detailTableView.register(UINib(nibName: "reviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
        detailTableView.rowHeight = UITableView.automaticDimension
        
        dataManager.getProductDetail(productNum: (productNum), delegate: self)
      
        
        print("viewDidLoadproductNum>>>>>>>\(productNum)")
        //self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBuy(_ sender: Any) {
//        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "buyVC")as? buyViewController else { return }
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        let buyVc = buyViewController()
//        buyVc.receiveItem(data : detail)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "optionTable") as! optionTableViewController
        presentPanModal(vc)
        vc.receiveItem(data: detail)
    }
    
    func receiveIndexPath(_ indexPath: Int) {
        productNum = indexPath
        print("productNum>>>>>>>\(productNum)\(indexPath)")
    }
}

extension detailViewController {
    func didSuccessProductDetail(data: detailViewRes) {
        detail = data.result
        detailTableView.reloadData()
    }
    func failedToRequest(message: String) {
    }
    
}

extension detailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0 : let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailTableCell", for: indexPath) as! detailViewTableViewCell
            return cell
       
        case 1 : let cell = detailTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! itemTableViewCell
            cell.selectionStyle = .none
            cell.sellerName.text = detail?.sellerName
            cell.itemName.text = detail?.name
            if let discount = detail?.rateOfDiscount{
                cell.discount.text = "\(discount)%"
            }
            
            if let price = detail?.reducedPrice {
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                if let price = numberFormatter.string(from: NSNumber(value: (price))) {
                cell.price.text = "\(price)"
                }
            }
            
            if let oriprice = detail?.price{
                cell.oriPrice.text = "\(oriprice)"
            }
            if let review = detail?.numOfReview{
                cell.numOfReview.text = "\(review)"
            }
            if let customer = detail?.numOfCustomer{
                cell.numberOfCustomer.text = "\(customer)"
            }
            if let profile = detail?.sellerProfile {
                let url = URL(string: "\(profile)")
                DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!)
                DispatchQueue.main.async {
                    cell.sellerImg.image = UIImage(data: data!)
                    }
                }
            }
            return cell
        case 2 : let cell = detailTableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! imageTableViewCell
            cell.selectionStyle = .none
            return cell
            
        case 3 : let cell = detailTableView.dequeueReusableCell(withIdentifier: "contentCell", for: indexPath) as! contentTableViewCell
            cell.selectionStyle = .none
            
            if let delivery = detail?.deliveryCharge {
                    let numberFormatter = NumberFormatter()
                    numberFormatter.numberStyle = .decimal
                if let price = numberFormatter.string(from: NSNumber(value: (delivery))) {
                cell.deliveryCharge.text = "\(price)원"
                }
            }
            if let free = detail?.freeShippingCondition {
                cell.freeShippingCondition.text = "\(free)원 이상 무료배송"
            }
            cell.deliveryDay.text = detail?.deliveryDay
            if let stock = detail?.totalStock {
                if stock < 0 {
                    cell.totalStack.text = "주문시 제작"
                } else {
                    cell.totalStack.text = "\(stock)"
                }
            }
            cell.content.numberOfLines = 0
            cell.content.lineBreakMode = .byCharWrapping
            cell.content.text = detail?.content.replacingOccurrences(of: "\\n", with: "\n")
            cell.prodPolicyName.text = detail?.prodPolicyName
            cell.prodPolicyDetail.text = detail?.prodPolicyDetail
            cell.refundPolicyDetail.text = detail?.refundPolicyDetail
            
            
            return cell
            
        case 4: let cell = detailTableView.dequeueReusableCell(withIdentifier: "reviewCell") as! reviewTableViewCell
            
            return cell
            
            
        default : UITableViewCell()
        }
        return UITableViewCell()
    }
}


extension detailViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 500
        }
        return tableView.rowHeight
    }
}
