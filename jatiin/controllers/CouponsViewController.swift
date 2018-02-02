//
//  CouponsViewController.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit
struct Coupon {
    var id:Int
    var name:String
    var intro:String
    var price:String
    var picurlstr:String
    
//    "id":1,
//    "name":"商品1",
//    "intro":"介绍1",
//    "create_time":1514201781,
//    "uid":1,
//    "price":"100",
//    "picurlstr":"picurl"
}
class CouponsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var dataSource = [Coupon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.requestData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func requestData() {
        XYWNetwork.requestCouponsList(start: 0, limit: 20) { (response) in
            switch response.result {
            case .success(let json):
                guard let resultDic = json as? Dictionary<String,Any> else {
                    XYWNetwork.showAlert(message: "数据格式有误", title: nil)
                    return
                }
                guard let code = resultDic["code"] as? Int,let msg = resultDic["msg"] as? String else {
                    XYWNetwork.showAlert(message: "数据格式有误", title: nil)
                    return
                }
                if code == 0 {
                    XYWNetwork.showAlert(message: msg, title: nil)
                }else {
                    let datas = resultDic["data"]
                    
                    guard let dataArray = datas as? Array<Dictionary<String,Any>> else {
                        XYWNetwork.showAlert(message: "数据格式有误", title: nil)
                        return
                    }
                    self.dataSource.removeAll()
                    for itm in dataArray {
                        guard let aid = (itm["id"] as? NSNumber)?.intValue else{
                            continue
                        }
                        guard let aprice = itm["price"] as? String else{
                            continue
                        }
                        let acou = Coupon(id:aid, name: itm["name"] as! String, intro: itm["intro"] as! String, price: aprice, picurlstr: itm["picurlstr"] as! String)
                        self.dataSource.append(acou)
                    }
                    self.tableView.reloadData()
                }
                print(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
class couponsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var coupon :Coupon! = nil {
        didSet{
            self.nameLabel.text = coupon.name
            self.priceLabel.text = coupon.price
            if let url = URL.init(string: coupon.picurlstr) {
//                self.imgView.setImageWith(url, options: <#T##YYWebImageOptions#>)
                self.imgView.setImageWith(url, placeholder: UIImage.init(color: UIColor.lightGray))
            }
            
        }
    }
    
}
extension CouponsViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "couponsTableViewCell", for: indexPath) as! couponsTableViewCell
        let cou = self.dataSource[indexPath.row]
        cell.coupon = cou
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cou = self.dataSource[indexPath.row]
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        if let detailVC = sb.instantiateViewController(withIdentifier: "CouponDetailViewController") as? CouponDetailViewController {
            detailVC.coupon = cou
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
