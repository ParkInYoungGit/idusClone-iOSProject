//
//  todayViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/16.
//

import UIKit

class todayViewController: UIViewController{
    var testArr = ["1","2"]
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "todayTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
        tableView.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell2")
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "headerCell")

    }

}

extension todayViewController: UITableViewDelegate, UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
           return 280
        }
        if indexPath.row == 1 {
            return 40
        }
        if indexPath.row == 2 {
            return 700
        }
        
        return 0
       }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //cell.textLabel?.text = testArr[1]
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? todayTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if indexPath.row == 1{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as? HeaderTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        
        if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as? SecondTableViewCell {
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }




}
