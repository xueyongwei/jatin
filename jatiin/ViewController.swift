//
//  ViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit
import SnapKit
import YYKit

class ViewController: UIViewController {

    @IBOutlet weak var leftMenuView: UIView!
    
    @IBOutlet weak var leftMenuCotainView: UIView!
    
    @IBOutlet weak var leftMenuCotainViewLeadingConst: NSLayoutConstraint!
 
//    var leftMenuViewTableViewController :LeftMenuTableViewControllerDelegate?
    
    lazy var leftMenuViewTableViewController :LeftMenuTableViewController = {
        let vc:LeftMenuTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuTableViewController") as! LeftMenuTableViewController
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customLeftMenuViewController()
        self.customRightBarItem()
        
        self.checkAuth()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func customLeftMenuViewController() {
        self.addChildViewController(self.leftMenuViewTableViewController)
        self.leftMenuCotainView.addSubview(self.leftMenuViewTableViewController.view)
        self.leftMenuViewTableViewController.view.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.bottom.equalTo(0)
        }
    }

    func customRightBarItem() {
        let infoView = UIView()
        infoView.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(onInfoTap))
        infoView.isUserInteractionEnabled = true
        infoView.addGestureRecognizer(tap)
        
        
        let userNameLabel = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        userNameLabel.textAlignment = NSTextAlignment.right
        userNameLabel.text = "Yuri"
        infoView.addSubview(userNameLabel)
        
        let userCountLabel = UILabel.init(frame: CGRect(x: 0, y: 22, width: 100, height: 22))
        userCountLabel.textColor = UIColor.blue
        userCountLabel.text = "99"
        userCountLabel.textAlignment = NSTextAlignment.right
        infoView.addSubview(userCountLabel)
        
        let rightBaritm = UIBarButtonItem.init(customView: infoView)
        
        self.navigationItem.rightBarButtonItem = rightBaritm
        
    }
    
    func checkAuth() {
        let corver = UIView.init(frame: UIScreen.main.bounds)
        corver.backgroundColor = UIColor.white
        self.navigationController?.view .addSubview(corver)
        
        
        let logVC = UIStoryboard.init(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let authNavi = UINavigationController.init(rootViewController: logVC)
        
        self.navigationController?.present(authNavi, animated: true, completion: {
            corver.removeFromSuperview()
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(initDataRequest), name: NSNotification.Name(rawValue: kAuthLoginSucessNotiName), object: nil)
        
    }
   
    @objc func initDataRequest() {
        
    }
    @IBAction func menuCLick(_ sender: UIButton) {
        
        var leadingConst:CGFloat = 0
        var alpha:CGFloat = 1
        
        if self.leftMenuView.alpha == 1 {
            leadingConst = -UIScreen.main.bounds.size.width*0.5
            alpha = 0
        }
        
        self.leftMenuCotainViewLeadingConst.constant = leadingConst
        self.leftMenuViewTableViewController.view.snp.updateConstraints { (maker) in
            maker.leading.equalTo(leadingConst)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.leftMenuView.alpha = alpha
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func onInfoTap() {
        
        let acountVC:AcountTableViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AcountTableViewController") as! AcountTableViewController
        
        self.navigationController?.pushViewController(acountVC, animated: true)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

