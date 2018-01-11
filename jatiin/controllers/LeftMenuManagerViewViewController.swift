//
//  LeftMenuManagerViewViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit
import YYKit
class LeftMenuManagerViewViewController: BaseViewController {

    public var leftMeauTableViewController:LeftMenuTableViewController!
    
    public weak var menuBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.loadLeftTableViewController()
        
        
        // Do any additional setup after loading the view.
    }

    func loadLeftTableViewController() {
        
         let sb = UIStoryboard(name: "Main", bundle: nil)
        
        self.leftMeauTableViewController = sb.instantiateViewController(withIdentifier: "LeftMenuTableViewController") as? LeftMenuTableViewController

//        self.addChildViewController(self.leftMeauTableViewController!)
        self.view.addSubview((self.leftMeauTableViewController?.view)!)
        self.leftMeauTableViewController.view.snp.makeConstraints { (maker) in
            maker.top.bottom.equalTo(0)
            maker.width.equalToSuperview().multipliedBy(0.4)
            maker.leading.equalTo(-YYScreenSize().width*0.5)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        menuBtn.isSelected = false
        self.hiddenMenu()
    }
    public func showMenu(onView:UIView){
        if self.view.superview == nil {
            onView .addSubview(self.view)
            self.view.snp.makeConstraints({ (maker) in
                maker.leading.trailing.top.bottom.equalTo(0)
            })
            self.view.layoutIfNeeded()
        }
        
        self.leftMeauTableViewController.view.snp.updateConstraints { (maker) in
            maker.leading.equalTo(0)
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1;
            self.view.layoutIfNeeded()
        }) { (finished) in
            
        }
    }
    
    public func hiddenMenu(){
        if self.view.superview == nil {
            return
        }
        self.leftMeauTableViewController.view.snp.updateConstraints { (maker) in
            maker.leading.equalTo(-YYScreenSize().width*0.5)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 0.1;
            self.view.layoutIfNeeded()
            print("change")
        }) { (finished) in
            if finished == true {
                self.view .removeFromSuperview()
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
