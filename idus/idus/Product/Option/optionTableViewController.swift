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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tvlistView.delegate = self
        tvlistView.dataSource = self

        tvlistView.register(UINib(nibName: "optionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        if let productNum = detail?.itemIdx {
            dataManager.getOption(productNum: productNum, delegate: self)
        }
    }

    func receiveItemToOption(data : detailResult?) {
        detail = data
        print("optionTableView>>>>>>>>>>>>>>>>>\(data)")
        //print("\(item.count)")
    }

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
        
//        for i in 0 ... item.count {
//            switch item[i].optionNum {
//            case 1:
//                return 1
//            case 2:
//                return 2
//            case 3:
//                return 3
//            default:
//                return 1
//            }
//        }
        return 1
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
//
//        for i in 0 ..< item.count {
//            sections.append(item[i].optionName)
//        }
//
//        if indexPath.section == 0 {
//            let optionValue = item[indexPath.row].optionValue
//            cell.textLabel?.text = "\(optionValue)"
//        }
        let cell = tvlistView.dequeueReusableCell(withIdentifier: "optionCell") as! optionTableViewCell
        cell.lblNumber.text = "test"

        return cell
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
