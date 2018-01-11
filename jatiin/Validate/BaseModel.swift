//
//  BaseModel.swift
//  jatiin
//
//  Created by 西方 on 2018/1/11.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import Foundation
class BaseModel {
    var code:Int = 0
    var msg:String = "unknown error"
    
    class func createModel(with dic:Dictionary<String, Any>) -> BaseModel {
        let model = BaseModel()
        if let acode = dic["code"] as?Int {
            model.code = acode
        }
        if let msg = dic["msg"] as?String {
            model.msg = msg
        }
        return model
    }
}
