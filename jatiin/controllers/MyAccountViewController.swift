//
//  MyAccountViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit

class MyAccountViewController: BaseViewController {

    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var phoneLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onConfirmClick(_ sender: UIButton) {
        guard let name = self.nameLabel.text,let phone = self.phoneLabel.text,let email = self.emailLabel.text ,let pwd = self.passwordLabel.text else {
            return
        }
        XYWNetwork.requestEditPrfile(email: email, username: name, pwd: pwd, phone: phone) { (response) in
            switch response.result {
                
            case .success(let json):
                guard let data = json as? Dictionary<String, Any> else{
                    return
                }
                guard let code = data["code"] as? Int,let msg = data["msg"] as? String else {
                    return
                }
                
                if code == 1 {
                    XYWNetwork.showAlert(message: msg, title: nil)
                }else {
                    XYWNetwork.showAlert(message: msg, title: nil)
                }
            case .failure(let error):
                XYWNetwork.showAlert(message: error.localizedDescription, title: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
