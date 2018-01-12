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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customUI()
        // Do any additional setup after loading the view.
    }
    func customUI() {
       if let data = UserDefaults.standard.object(forKey: "userData") as? Dictionary<String,String>{
            self.nameLabel.text = data["username"]
        self.phoneLabel.text = data["phone"]
        self.emailLabel.text = data["email"]
        }
        
    }
    @IBAction func onLogoutClick(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "accesstoken")
        NotificationCenter.default.post(name: NSNotification.Name.AuthShouldCheckAgain, object: nil)
//        let logVC = UIStoryboard.init(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        let authNavi = UINavigationController.init(rootViewController: logVC)
//
//        self.navigationController?.present(authNavi, animated: true, completion: {
//        })
    }
    
    
    @IBAction func onConfirmClick(_ sender: UIButton) {
        guard let name = self.nameLabel.text,let phone = self.phoneLabel.text,let email = self.emailLabel.text else {
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
