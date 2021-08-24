//
//  optionTableViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import UIKit
import PanModal

class optionTableViewController: UITableViewController {
    var item: [optionResult] = []
    var dataManager = optionDataManager()
    var sections = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let productNum = detail?.itemIdx {
            dataManager.getOption(productNum: productNum, delegate: self)
        }
        
    }

    func receiveItem(data : detailResult?) {
        detail = data
        //print("optionTableView>>>>>>>>>>>>>>>>>\(data)")
        //print("\(item.count)")
    }

    func didSuccessOption(data : optionRes){
        item = data.result
        print("optionitemTableView>>>>>>>>>>>>>>>>>\(item)")
        tableView.reloadData()
    }

    func failedToRequest(message: String) {

    }

    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 400
//    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return item.count
    }

   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        
        for i in 0 ..< item.count {
            sections.append(item[i].optionName)
        }

        if indexPath.section == 0 {
            let optionValue = item[indexPath.row].optionValue
            cell.textLabel?.text = "\(optionValue)"
        }
        
//        let optionName = item[indexPath.row].optionName
//        let optionValue = item[indexPath.row].optionValue
//        // Configure the cell...
//        cell.textLabel?.text = "\(optionName)"
//        cell.textLabel?.text = "\(optionValue)"
        return cell
    }
    

}

extension optionTableViewController: PanModalPresentable {

    var panScrollable: UIScrollView? {
        return tableView
    }


}
