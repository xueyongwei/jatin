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
    static func getCouponsListUrl() -> String {
        return  baseUrl + getPath() + "/goods/getgoodslist/shop/goods?"
    }
    static func getPurchaseCouponsUrl() -> String {
        return  baseUrl + getPath() + "/goods/exchangegood/shop/pay?"
    }
    static func getEidtProfileUrl() -> String {
        return  baseUrl + getPath() + "/user/edit?"
    }
    static func getCountPointsUrl() -> String {
        return  baseUrl + getPath() + "/user/getscore/shop/account?"
    }
    static func getCountDetailUrl() -> String {
        return  baseUrl + getPath() + "/user/getlist/shop/accountdetail?"
    }
    static func getPath() -> String {
        return "app/api/v1"
    }
   
    //MARK: - REQUEST
    class func requestPointsDetailList(start:Int,limit:Int,completionHandler: @escaping (DataResponse<Any>) -> Void){
        let (isSucess,token) = self.checkAuthInfo()
        if isSucess {
            let urlStr = XYWNetwork.getCouponsListUrl() + "accesstoken=\(token)&start=\(start)&limit=\(limit)"
            //            let urlStr = XYWNetwork.getCouponsListUrl() + "accesstoken=\(String(describing: token))&start=\(start)&limit=\(limit)"
            Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
        }else{
            let result = Result<Any>.failure(AuthInfoError.notAuthed)
            
            let errResponse = DataResponse.init(request: nil, response: nil, data: nil, result: result)
            
            completionHandler(errResponse)
            return
        }
        
    }
    class func requestPoints(completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let (isSucess,token) = self.checkAuthInfo()
        if isSucess {
            let urlStr = XYWNetwork.getCountPointsUrl() + "accesstoken=\(token)"
            Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
        }else{
            let result = Result<Any>.failure(AuthInfoError.notAuthed)
            
            let errResponse = DataResponse.init(request: nil, response: nil, data: nil, result: result)
            
            completionHandler(errResponse)
            return
        }
    }
    class func requestRegist(username:String,email:String,paswd:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let urlStr = XYWNetwork.getRegisterUrl() + "email="+email+"&username="+username+"&pwd="+paswd
        
        Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
    }
    class func requestEditPrfile(email:String,username:String,pwd:String,phone:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let (isSucess,token) = self.checkAuthInfo()
        if isSucess {
            let urlStr = XYWNetwork.getEditProfileUrl() + "accesstoken=\(token)&email=\(email)&username=\(username)&pwd=\(pwd)&phone=\(phone)"
            Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
        }else{
            let result = Result<Any>.failure(AuthInfoError.notAuthed)
            
            let errResponse = DataResponse.init(request: nil, response: nil, data: nil, result: result)
            
            completionHandler(errResponse)
            return
        }
    }
    class func requestLogin(username:String,paswd:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let urlStr = XYWNetwork.getLgoinUrl() + "username="+username+"&pwd="+paswd
        
        Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
    }
    class func requestForgetPswd(username:String,email:String, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        
        let urlStr = XYWNetwork.getForgetPswdUrl() + "username="+username+"&email="+email
        
        Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
    }
  
    enum AuthInfoError :Error{
        case notAuthed
        case authExceed
        
        var localizedDescription: String {
            switch self {
            case .notAuthed:
                return "还未登录！"
            default:
                return "用户信息有误！"
            }
        }
    }
    
    class func requestCouponsList(start:Int,limit:Int,completionHandler: @escaping (DataResponse<Any>) -> Void){
        let (isSucess,token) = self.checkAuthInfo()
        if isSucess {
            let urlStr = XYWNetwork.getCouponsListUrl() + "accesstoken=\(token)&start=\(start)&limit=\(limit)"
//            let urlStr = XYWNetwork.getCouponsListUrl() + "accesstoken=\(String(describing: token))&start=\(start)&limit=\(limit)"
            Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
        }else{
            let result = Result<Any>.failure(AuthInfoError.notAuthed)
            
            let errResponse = DataResponse.init(request: nil, response: nil, data: nil, result: result)
            
            completionHandler(errResponse)
            return
        }
        
    }
    
    class func requestPurchaseCoupon(goodsid:Int,score:String,completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let (isSucess,token) = self.checkAuthInfo()
        if isSucess {
            let urlStr = XYWNetwork.getPurchaseCouponsUrl() + "accesstoken=\(token)&goodsid=\(goodsid)&score=\(score)"
            Alamofire.request(urlStr).responseJSON(completionHandler: completionHandler)
            
        }else{
            let result = Result<Any>.failure(AuthInfoError.notAuthed)
            
            let errResponse = DataResponse.init(request: nil, response: nil, data: nil, result: result)
            
            completionHandler(errResponse)
            return
        }
    }
    
    class func checkAuthInfo() -> (isSucess:Bool,token:String) {
        if let token = UserDefaults.standard.string(forKey: "accesstoken") {
            return (true,token)
        }
        return (false,"error")
    }
    
    //MARK: - Alert message
   class func showAlert(message:String,title:String?) ->Void {
        let alert = UIAlertView.init(title: title, message: message, delegate: nil, cancelButtonTitle: "OK")
        alert.show()
    }
    
}

