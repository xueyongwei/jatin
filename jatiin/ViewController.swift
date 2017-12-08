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
public let kChangeMainViewNotificationName = "ChangeMainViewNotificationName"

class ViewController: UIViewController,LeftMenuTableViewControllerDelegate {

    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var leftMenuView: UIView!
    
    @IBOutlet weak var leftMenuCotainView: UIView!
    
    @IBOutlet weak var leftMenuCotainViewLeadingConst: NSLayoutConstraint!
 
//    var leftMenuViewTableViewController :LeftMenuTableViewControllerDelegate?
    
    var childrenViewControllerInfo: [String:Any]?
    var childrenViewControllerClassNames: [String]?
    
    var currentChildrenViewControllerIndex :Int = 0
    
    lazy var leftMenuViewTableViewController :LeftMenuTableViewController = {
        let vc:LeftMenuTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LeftMenuTableViewController") as! LeftMenuTableViewController
        vc.deletage = self
        return vc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customLeftMenuViewController()
        self.customRightBarItem()
        
        self.checkAuth()
        
        self.registNotificationCenter()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func registNotificationCenter()  {
        NotificationCenter.default.addObserver(self, selector: #selector(initDataRequest), name: NSNotification.Name(rawValue: kAuthLoginSucessNotiName), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeMainView), name: NSNotification.Name(kChangeMainViewNotificationName), object: nil)
        
        
    }
    //MARK: custom
    func customLeftMenuViewController() {
        self.addChildViewController(self.leftMenuViewTableViewController)
        self.leftMenuCotainView.addSubview(self.leftMenuViewTableViewController.view)
        self.leftMenuViewTableViewController.view.snp.makeConstraints { (maker) in
            maker.leading.trailing.top.bottom.equalTo(0)
        }
        
        self.childrenViewControllerClassNames = ["CouponsViewController","MyAccountViewController","PartnersViewController","HelpViewController"]
        for className in self.childrenViewControllerClassNames! {
            let cvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: className)
            self.addChildViewController(cvc)
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
        
        
        
    }
    //MARK: 回调事件
    @objc func initDataRequest() {
        
    }
    
    @objc func changeMainView(toIndex:Int) {
        
        guard toIndex != currentChildrenViewControllerIndex else {
            return
        }
        
        let curtVC = self.childViewControllers[currentChildrenViewControllerIndex]
        curtVC.view.removeFromSuperview()
        
        let toVC = self.childViewControllers[toIndex]
        self.view.addSubview(toVC.view)
        
        toVC.view.snp.makeConstraints { (maker) in
            maker.trailing.leading.bottom.top.equalTo(0)
        }
        
        
    }
    //MARK: 点击事件
    @IBAction func menuCLick(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        sender.isUserInteractionEnabled = false
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
    
        UIView.animate(withDuration: 0.3, animations: {
            self.leftMenuView.alpha = alpha
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished == true{
                self.menuButton.isUserInteractionEnabled = true
                self.leftMenuViewTableViewController.view.isHidden = !sender.isSelected
            }
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
    
    //MARK:LeftMenuTableViewControllerDelegate
    
    func LeftMenuTableViewControllerDidSelectedIndexPath(indexPath: IndexPath) {
        self.changeMainView(toIndex: indexPath.row)
        self.menuCLick(menuButton)
    }

}

