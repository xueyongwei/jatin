//
//  ForgetPasswordViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: BaseViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onNextClick(_ sender: UIButton) {
        guard let username = usernameTF.text , let email = emailTF.text else {
            XYWNetwork.showAlert(message: "所有内容必须填写", title: nil)
            return
        }
        if username.count < 5 {
            XYWNetwork.showAlert(message: "用户名至少5位", title: nil)
            return
        }
        if email.count < 4 {
            XYWNetwork.showAlert(message: "邮箱至少4位", title: nil)
            return
        }
        XYWNetwork.requestForgetPswd(username: username, email: email) { (response) in
            switch response.result {
            case .success(let json) :
                guard let data = json as? [String:Any] else {
                    XYWNetwork.showAlert(message: "数据有误！", title: nil)
                    return
                }
                if let code = data["code"] as? Int,let msg = data["msg"] as? String {
                    XYWNetwork.showAlert(message: msg, title: nil)
                    if code == 1{
                        self.navigationController?.popViewController(animated: true)
                    }
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
