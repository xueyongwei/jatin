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

    
    @IBAction func onLoginClick(_ sender: UIButton) {
        
        self.navigationController?.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kAuthLoginSucessNotiName), object: nil)
        })
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
