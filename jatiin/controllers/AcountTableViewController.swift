//
//  AcountTableViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit
import SwiftyJSON
class ConsumeTableViewCell:UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var model:ConsumeItem? {
        didSet{
            self.nameLabel.text = model?.name
            self.priceLabel.text = String.init(format: "paied:%d points", (model?.price)!)
            let dataFormate = DateFormatter.init()
            dataFormate.dateFormat = "YY-MM-dd hh:mm"
            
            self.timeLabel.text = dataFormate.string(from: (model?.create_time)!)
           
            if let imgurlStr = model?.picurlstr, let imgUrl = URL.init(string: imgurlStr){
                self.imgView.setImageWith(imgUrl, placeholder: UIImage.init(named:"logo"))
            }
            
        }
    }
    
}

class ConsumeItem {
    var name:String = ""
    var picurlstr:String = ""
    var price:Int = 0
    var intro:String = ""
    var create_time:Date = Date()
}

class AcountTableViewController: UITableViewController {

    var dataSource = [ConsumeItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detail"
        self.requestData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func requestData() {
        XYWNetwork.requestPointsDetailList(start: 0, limit: 100) { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let datas = json["data"].array {
                    self.dataSource.removeAll()
                    for data in datas{
                        let con = ConsumeItem.init()
                        con.name = data["name"].stringValue
                        con.picurlstr = data["picurlstr"].stringValue
                        con.price = data["price"].intValue
                        let tim = data["create_time"].doubleValue
                        let date = Date.init(timeIntervalSince1970: tim)
                        con.create_time = date
//                        self.dataSource.insert(con, at: 0)
                        self.dataSource.append(con)
                    }
                    self.tableView.reloadData()
                }
            case .failure(let error):
                XYWNetwork.showAlert(message: error.localizedDescription, title: nil)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsumeTableViewCell", for: indexPath) as! ConsumeTableViewCell
        
        let amodel = self.dataSource[indexPath.row]
        cell.model = amodel

        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
