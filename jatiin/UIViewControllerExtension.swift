//
//  UIViewControllerExtension.swift
//  jatiin
//
//  Created by 西方 on 2018/1/19.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import UIKit

extension UIViewController{
    class func initFromeStoryBord(named:String) -> UIViewController {
        let sb = UIStoryboard.init(name: named, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: self.classForCoder()))
        return vc
    }
}
