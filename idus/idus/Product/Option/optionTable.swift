//
//  optionTable.swift
//  idus
//
//  Created by YOUNG on 2021/08/24.
//

import Foundation
import UIKit
import PanModal

class optionTable: UITableViewController {
    //var item: [optionResult] = []
    //var dataManager = optionDataManager()
    @IBOutlet weak var optionTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        optionTableView.delegate = self
        optionTableView.dataSource = self
    
        
//        if let productNum = detail?.itemIdx {
//            dataManager.getProduct(productNum: productNum, delegate: self)
//        }
//    }

//    func receiveItem(data : detailResult?) {
//        detail = data
//        print(">>>>>>>>>>>>>>>>>\(data)")
//    }
//
//    func didSuccessOption(data : optionRes){
//        item = data.result
//        optionTableView.reloadData()
//    }
//
//    func failedToRequest(message: String) {
//
//    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
          // #warning Incomplete implementation, return the number of sections
          return 1
      }

      // 섹션당 열의 갯수는 item의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of rows
          return 3
      }

      
      // 셀(Cell)의 구성 정의
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)

          // Configure the cell...
        cell.textLabel?.text = "test"
          return cell
      }

    
}

}


//extension optionTable: PanModalPresentable {
//
//    var panScrollable: UIScrollView? {
//        return tableView
//    }
//
//
//}

