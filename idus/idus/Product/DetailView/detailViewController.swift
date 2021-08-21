//
//  detailViewController.swift
//  idus
//
//  Created by YOUNG on 2021/08/21.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var detailViewToolbar: UIToolbar!
    @IBOutlet weak var likeBtn: UIBarButtonItem!
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UINib(nibName: "detailViewTableViewCell", bundle: nil), forCellReuseIdentifier: "detailTableCell")
        detailTableView.register(UINib(nibName: "itemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        detailTableView.rowHeight = UITableView.automaticDimension
    }
}

extension detailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 : let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailTableCell", for: indexPath) as! detailViewTableViewCell
            return cell
        case 1 : let cell = detailTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! itemTableViewCell
            return cell
        default : UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.rowHeight
    }
    

    
    
}
