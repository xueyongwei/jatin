//
//  CouponDetailViewController.swift
//  jatiin
//
//  Created by 西方 on 2018/1/11.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import UIKit
import SwiftyJSON
class CouponDetailViewController: UIViewController {

    var coupon :Coupon?
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.customUI()
        // Do any additional setup after loading the view.
    }

    func customUI() {
        self.titleLabel.text = self.coupon?.name
        self.priceLabel.text = self.coupon?.price
        if let urlStr = self.coupon?.picurlstr,let url = URL.init(string: urlStr) {
            self.imgView.setImageWith(url, placeholder: UIImage.init(color: UIColor.lightGray))
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackClick(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onPurchaseClick(_ sender: UIButton) {
        let alv = UIAlertController.init(title: "确认兑换？", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let cancle = UIAlertAction.init(title: "Cancle", style: UIAlertActionStyle.cancel) { (action) in
        }
        let purchase = UIAlertAction.init(title: "Purchase", style: UIAlertActionStyle.default) { (action) in
            self.requestToPurchase()
        }
        alv.addAction(cancle)
        alv.addAction(purchase)
        self.present(alv, animated: true, completion: nil)
        
    }
    func requestToPurchase() {
        guard let sid = self.coupon?.id,let score = self.coupon?.price else {
            return
        }
        XYWNetwork.requestPurchaseCoupon(goodsid: sid, score: score) { (response) in
            switch response.result {
                
            case .success(let json):
                print(json)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
