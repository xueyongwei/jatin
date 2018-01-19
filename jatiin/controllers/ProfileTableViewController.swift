
//
//  ProfileTableViewController.swift
//  jatiin
//
//  Created by 西方 on 2018/1/12.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var userphoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(customUI), name: Notification.Name.CountShouldRefresh, object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func customUI() {
        if let data = UserDefaults.standard.object(forKey: "userData") as? Dictionary<String,String>{
            self.userIDLabel.text = "userID: \(data["id"] ?? "private")"
            self.usernameLabel.text = "userName: \(data["username"] ?? "private")"
            self.userphoneLabel.text = "phone: \(data["phone"] ?? "not set")"
            self.useremailLabel.text = "email: \(data["email"] ?? "private")"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logOut()  {
        UserDefaults.standard.removeObject(forKey: "accesstoken")
        NotificationCenter.default.post(name: NSNotification.Name.AuthShouldCheckAgain, object: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
//            case 0 :
//                let count = MyAccountViewController.initFromeStoryBord(named: "Main")
////                let count = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyAccountViewController")
//                self.navigationController?.pushViewController(count, animated: true)
//            case 1 :
//                let edipswd = EditPasswordViewController.initFromeStoryBord(named: "Main")
//                self.navigationController?.pushViewController(edipswd, animated: true)
            case 2 :
                self.logOut()
            default:
                break
            }
        }
    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
