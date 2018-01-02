//
//  RegisterViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire

class RegisterViewController: BaseViewController {
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onRegisteClick(_ sender: UIButton) {
        guard let username = self.usernameTF.text,
            let email = self.emailTF.text,
            let password = self.passwordTF.text,
            let confirm = self.confirmTF.text
            else {
                XYWNetwork.showAlert(message:"请全部填写", title: nil)
            return
        }
        
        if username.count < 5 {
            XYWNetwork.showAlert(message: "用户名至少5位", title: nil)
            return
        }
        if password.count < 5 {
            XYWNetwork.showAlert(message: "密码至少5位", title: nil)
            return
        }
        if password != confirm {
            XYWNetwork.showAlert(message:"密码两次输入不一致", title: nil)
            return
        }
      
        
        XYWNetwork.requestRegist(username: username, email: email, paswd: password) { [weak self] (response) in
            switch response.result {
            case.success(let json):
                if let data = json as? Dictionary<String, Any> {
                    if let code = data["code"] as? Int,let msg = data["msg"] as? String{
                        if code == 0 {
                            XYWNetwork.showAlert(message:msg, title: nil)
                        }else {
                            XYWNetwork.showAlert(message:msg, title: nil)
                            self?.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            case .failure(let error):
                print(error)
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
