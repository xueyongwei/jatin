//
//  EditPasswordViewController.swift
//  jatiin
//
//  Created by 西方 on 2018/1/19.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import UIKit

class EditPasswordViewController: UIViewController {

    @IBOutlet weak var pasTF: UITextField!
    @IBOutlet weak var conPasTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onConfirmClick(_ sender: UIButton) {
        guard let psw = pasTF.text,psw.count > 5 else {
            XYWNetwork.showAlert(message: "请输入至少6位密码", title: nil)
            return
        }
        if pasTF.text == conPasTF.text {
            XYWNetwork.requestEditPswd(newpswd: pasTF.text!, completionHandler: { (response) in
                switch response.result {
                case .success(let json):
                    if let data = json as? Dictionary<String, Any> {
                        if let code = data["code"] as? Int,let msg = data["msg"] as? String{
                            print(data)
                            if code == 0 {
                                XYWNetwork.showAlert(message:msg, title: nil)
                            }else {
                                XYWNetwork.showAlert(message:msg, title: nil)
                            }
                        }
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }else{
            XYWNetwork.showAlert(message: "两次输入不一致！", title: nil)
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
