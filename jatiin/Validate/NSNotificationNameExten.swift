//
//  NSNotificationNameExten.swift
//  jatiin
//
//  Created by 西方 on 2018/1/11.
//  Copyright © 2018年 xueyongwei. All rights reserved.
//

import Foundation

extension NSNotification.Name {
    static let LoginDidSucess = Notification.Name("LoginDidSucess")
    static let LeftMenuTableViewClickIndex = Notification.Name("LeftMenuTableViewClickIndex")
    static let AuthShouldCheckAgain = Notification.Name("AuthShouldCheckAgain")
    static let PointsShouldRefresh = Notification.Name("PointsShouldRefresh")
    static let CountShouldRefresh = Notification.Name("CountShouldRefresh")
}
