//
//  reviewTableViewCell.swift
//  idus
//
//  Created by YOUNG on 2021/08/25.
//

import UIKit

class reviewTableViewCell: UITableViewCell {

    var item: [reviewResult?] = []
    var reviewdataManager = reviewDataManager()
    @IBOutlet weak var reviewContentTableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        reviewContentTableView.delegate = self
        reviewContentTableView.dataSource = self
        reviewContentTableView.register(UINib(nibName: "reviewContentTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewContentCell")
        reviewdataManager.getProductReview(productNum: productNum, delegate: self)
        reviewContentTableView.rowHeight = UITableView.automaticDimension
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didSuccessProductReview(data: reviewRes){
        item = data.result
        print("들어왔니??\(item)\(item.count)")
        reviewContentTableView?.reloadData()
    }
    
    func failedToRequest(message: String) {
        
    }
    
    
}

extension reviewTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewContentTableView.dequeueReusableCell(withIdentifier: "reviewContentCell") as! reviewContentTableViewCell
        let detail = item[indexPath.row]
        
        cell.userName.text = detail?.userName
        cell.createdDate.text = detail?.createdDate
        if let photo = detail?.userProfile{
            let url = URL(string: photo)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        cell.userProfile.image = UIImage(data: data)
                    }
                }
            }
        }
        
        if let photo = detail?.reviewPhoto{
            let url = URL(string: photo)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async {
                        cell.reviewPhoto.image = UIImage(data: data)
                    }
                }
            }
        }
        
        
        cell.reviewContent.text = detail?.reviewContent.replacingOccurrences(of: "\\n", with: "\n")
//        cell.option.text = "\(detail?.option1Value)\(detail?.option1Name),\(detail?.option2Value)\(detail?.option2Name),\(detail?.option3Value)\(detail?.option3Name)"
//
        if let optionValue1 = detail?.option1Value, let optionName1 = detail?.option1Name, let optionValue2 = detail?.option2Value, let optionName2 = detail?.option2Name, let optionValue3 = detail?.option3Value, let optionName3 = detail?.option3Name {
            cell.option.text = "\(optionName1) \(optionValue1)  \(optionName2) \(optionValue2) \(optionName3)   \(optionValue3)"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
