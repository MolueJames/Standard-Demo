//
//  YunZhouUserService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/7.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

public struct UserService {
    /// 用户登录接口
    /// - Parameter username: 用户账号
    /// - Parameter password: 用户密码
    public static func doLogin(username: String, password: String) -> AppDataRequest {
        let parameter = ["code": username, "password": password]
        let path: String = "/certi_auth/usersInfo/session/login"
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    /// 用户登出接口
    public static func doLogout() -> AppDataRequest {
        let path: String = "/certi_auth/usersInfo/session/logout"
        return AppDataRequest(parameter: nil, method: .post, path: path, encoding: JSONEncoding.default)
    }
}
