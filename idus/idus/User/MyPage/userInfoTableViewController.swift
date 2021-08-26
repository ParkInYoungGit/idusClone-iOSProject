//
//  userInfoTableViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/26.
//

import UIKit

class userInfoTableViewController: UITableViewController {

    var dataManager = userInfoDataManager()
    var data: [userInfoResult?] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager.registrationUserInfo(delegate: self)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    func didSuccessUserInfo(_ result: userInfoRes) {
        data = result.result
        print("\(data)")
        print(data.count)
        tableView.reloadData()
    }
    func failedTouserInfoRequest(message: String) {
        //self.presentAlert(title: message)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoCell", for: indexPath) as! userInfoTableCell
        let item = data[indexPath.row]
        
        let url = URL(string: "\(item!.itemPhoto)")
        DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            cell.itemImg.image = UIImage(data: data!)
            }
        }
        
        cell.itemName.text = item?.itemName
        cell.optionName.text = item?.option1Name
        cell.optionValue.text = item?.option1Value
        if let quantity = item?.purchaseQuantity {
            cell.quantity.text = "\(quantity)개"
        }
        cell.recipientName.text = item?.recipientName
        cell.recipientPhone.text = item?.recipientphone
        cell.address.text = item?.address
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
