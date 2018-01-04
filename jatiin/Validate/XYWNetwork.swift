//
//  XYWNetwork.swift
//  jatiin
//
//  Created by 西方 on 2017/12/31.
//  Copyright © 2017年 xueyongwei. All rights reserved.
//

import Foundation
import Alamofire


class XYWNetwork {
    static let baseUrl = "http://localhost:8888/"
    
    //MARK: - Get URL
    static func getRegisterUrl() -> String {
        return  baseUrl + getPath() + "/user/register?"
    }
    static func getLgoinUrl() -> String {
        return  baseUrl + getPath() + "/user/login?"
    }
    static func getForgetPswdUrl() -> String {
        return  baseUrl + getPath() + "/user/find_password?"
    }
    static func getChangePswdUrl() -> String {
        return  baseUrl + getPath() + "/user/edit_password"
    }
    static func getEditProfileUrl() -> String {
        return  baseUrl + getPath() + "/user/edit?"
    }
    static func getPath() -> String {
        return "app/api/v1"
    }
   
    //MARK: - REQUEST
    class func requestRegist(username:String,email:String,paswd:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let urlStr = XYWNetwork.getRegisterUrl() + "email="+email+"&username="+username+"&pwd="+paswd
        
        Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
    }
    
    class func requestLogin(username:String,paswd:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let urlStr = XYWNetwork.getLgoinUrl() + "username="+username+"&password="+paswd
        
        Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
    }
    class func requestForgetPswd(username:String,email:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let urlStr = XYWNetwork.getForgetPswdUrl() + "username="+username+"&email="+email
        
        Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
    }
    
    //MARK: - Alert message
   class func showAlert(message:String,title:String?) ->Void {
        let alert = UIAlertView.init(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
}


