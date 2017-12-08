//
//  MainViewManager.swift
//  jatiin
//
//  Created by 西方 on 2017/12/8.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import UIKit

class MainViewManager: NSObject {
    
    class var shared:MainViewManager{
        struct Default {
            static let instance = MainViewManager()
        }
        return Default.instance
    }
    
    public var controller:ViewController?
    
    public var currentVC:BaseViewController?
    
    private var priCurrentVC:BaseViewController?
   
    
}
