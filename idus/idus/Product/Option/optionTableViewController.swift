//
//  optionTableViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import UIKit
import PanModal

class optionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tvlistView: UITableView!
    var item: [optionResult] = []
    var dataManager = optionDataManager()
    var sections = [""]
    var itemOpen: Bool = false
    var itemSeleted: Bool = false
    var optionCount = 0
    var arr: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvlistView.delegate = self
        tvlistView.dataSource = self

        tvlistView.register(UINib(nibName: "optionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        //tvlistView.reloadData()
        
        if let productNum = detail?.itemIdx {
            dataManager.getOption(productNum: productNum, delegate: self)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if let productNum = detail?.itemIdx {
            dataManager.getOption(productNum: productNum, delegate: self)
            tvlistView.reloadData()
        }
    }
//    func receiveItemToOption(data : detailResult?) {
//        detail = data
//        print("optionTableView>>>>>>>>>>>>>>>>>\(data)")
//        //print("\(item.count)")
//    }

    func didSuccessOption(data : optionRes){
        item = data.result
        tvlistView.reloadData()
        print("optionitemTableView>>>>>>>>>>>>>>>>>\(item)")
        
    }

    func failedToRequest(message: String) {

    }

    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        for i in 0 ..< item.count {
            arr = [item[i].optionNum]
            }
        if let maxValue = arr.max() {
            print("maxValuemaxValuemaxValuemaxValue\(maxValue)")
            return maxValue
            arr = Array()
        }
        return 1
    
            
//            print(">>>>item.count\(item[i].optionNum)")
//            if item[i].optionNum == 3 {
//            return 3
//            } else if item[i].optionNum == 2 {
//                    return 2
//            } else {
//                return 1
//            }
//        }
//        return 1
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if itemOpen == true {
            let count = arr.filter( {$0 == 1}).count
            return count + 1
            } else {
                return 1
            }
        case 1:
            if itemOpen == true {
                let count = arr.filter( {$0 == 2}).count
                return count + 1
                } else {
                    return 1
                }
        case 2:
            if itemOpen == true {
                let count = arr.filter( {$0 == 3}).count
                return count + 1
                } else {
                    return 1
                }
        default:
            return 1
        }
        }
        // #warning Incomplete implementatio n, return the number of rows
//        for i in 0 ..< item.count {
//            switch section {
//            case 0:
//                if itemOpen == true {
//                    let detailCount = item[i].optionName.count + 1
//                    return detailCount
//                } else {
//                    return 1
//                }
//            case 1:
//                if itemSeleted == true {
//                    var optionValueCount = item[i].optionValue.count + 1 {
//                        optionCount = optionValueCount
//                        return optionCount
//                    }
//                }
//
//
//
//
//            default:
//                return 1
//            }
//
//        }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tvlistView.dequeueReusableCell(withIdentifier: "optionCell") as! optionTableViewCell
   //     return cell
//        let data = item[indexPath.row - 1].optionName
//        let value = item[indexPath.row - 1].optionValue

        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                print("아이템!!:\(item)")
                var newIndex = indexPath.row
                cell.lblNumber.text = "1번 name"
                cell.lblOption.text = "인덱스패스"
            } else {
                cell.lblNumber.text = "1번 value"
                cell.lblOption.text = "\(item[0].optionValue)"
                
//                cell.lblNumber.text = "\(indexPath.section + 1)번"
//                cell.lblOption.text = "\(value)"
            }
        default:
            cell.lblNumber.text = "1번"
            cell.lblOption.text = "1"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            itemOpen = !itemOpen
            tableView.reloadData()
        } else {
            itemOpen = false
            tableView.reloadData()
            print("접어버렷")
        }
    }
}
extension optionTableViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return tvlistView
    }
    var shortFormHeight: PanModalHeight {
    return .contentHeight(430)
  }
  var longFormHeight: PanModalHeight {
    return .maxHeightWithTopInset(300)
  }
  var anchorModalToLongForm: Bool {
    return true
  }
}
