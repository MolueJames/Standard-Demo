//
//  YunZhouNotificationName.swift
//  YunZhouCommon
//
//  Created by James on 2018/7/26.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation

public protocol ToNotification {
    func toName() -> NSNotification.Name
}

public enum UserNotification: String {
    // MARK: - 用户取消登录
    case user_cancel = "user_cancel"
    // MARK: - 用户退出成功
    case user_logout = "user_logout"
    // MARK: - 用户需要登录
    case need_login = "need_login"
    // MARK: - 用户登录成功
    case user_login = "user_login"
}

extension UserNotification: ToNotification {
    public func toName() -> NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}

public enum UINotification: String {
    case orientationDidChaned = "orientationDidChanged"
    
}

extension UINotification: ToNotification {
    public func toName() -> NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}
