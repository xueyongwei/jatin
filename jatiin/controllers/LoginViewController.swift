//
//  LoginViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit


public let kAuthLoginSucessNotiName = "loginSucessNotiName"

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    
    @IBOutlet weak var pswTF: UITextField!
    @IBAction func onLoginClick(_ sender: UIButton) {
        
        guard let username = usernameTF.text , let pswd = pswTF.text else {
            XYWNetwork.showAlert(message: "所有内容必须填写", title: nil)
            return
        }
        if username.count < 5 {
            XYWNetwork.showAlert(message: "用户名至少5位", title: nil)
            return
        }
        if pswd.count < 5 {
            XYWNetwork.showAlert(message: "密码至少5位", title: nil)
            return
        }
        
        XYWNetwork.requestLogin(username: username, paswd: pswd) { [weak self](response) in
            switch response.result {
            case .success(let json):
                guard let data = json as? Dictionary<String,Any> else {
                    XYWNetwork.showAlert(message: "数据格式有误", title: nil)
                    return
                }
                guard let code = data["code"] as? Int,let msg = data["msg"] as? String else {
                    XYWNetwork.showAlert(message: "数据格式有误", title: nil)
                    return
                }
                if code == 0 {
                    XYWNetwork.showAlert(message: msg, title: nil)
                }else {
                    
                    let token = data["accesstoken"]
                    var dic = [String:String]()
                    if let userData = data["data"] as? Dictionary<String,Any> {
                        
                        dic["email"] = userData["email"] as? String ?? ""
                        dic["id"] = userData["id"] as? String ?? ""
                        dic["password"] = userData["password"] as? String ?? ""
                        dic["phone"] = userData["phone"] as? String ?? ""
                        dic["username"] = userData["username"] as? String ?? ""
                    }
                    UserDefaults.standard.set(dic, forKey: "userData")
                    UserDefaults.standard.set(token, forKey: "accesstoken")
                    XYWNetwork.showAlert(message: msg, title: nil)
                    self?.navigationController?.dismiss(animated: true, completion: {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kAuthLoginSucessNotiName), object: nil)
                        
                    })
                }
                
                
            case .failure(let error):
                XYWNetwork.showAlert(message: error.localizedDescription, title: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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

//- key : "data"
//▿ value : 10 elements
//▿ 0 : 2 elements
//- key : phone
//- value : <null>
//▿ 1 : 2 elements
//- key : password
//- value : c56191dfc1b9b38628b90b50f831d163
//▿ 2 : 2 elements
//- key : score
//- value : 0
//▿ 3 : 2 elements
//- key : id
//- value : 7
//▿ 4 : 2 elements
//- key : update_time
//- value : <null>
//▿ 5 : 2 elements
//- key : is_delete
//- value : 1
//▿ 6 : 2 elements
//- key : reason
//- value : <null>
//▿ 7 : 2 elements
//- key : username
//- value : user2
//▿ 8 : 2 elements
//- key : email
//- value : xyw2@xyw.pub
//▿ 9 : 2 elements
//- key : create_time
//- value : 1515146563

