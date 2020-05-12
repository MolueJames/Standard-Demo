//
//  YunZhouNetworkConfigure.swift
//  YunZhouSafty
//
//  Created by James on 2018/4/16.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation

public enum AppSchemeStatus {
    case debug
    case release
    public static func base() -> AppSchemeStatus {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
}

public struct HTTPConfigure {
    public static var baseURL: String  {
        switch AppSchemeStatus.base() {
        case .debug:
            return "http://47.103.85.89:8081"
        case .release:
            return "http://47.103.85.89:8081"
        }
    }
}

public protocol ActivityDelegate: NSObjectProtocol {
    func networkActivityStarted()
    func networkActivitySuccess()
    func networkActivityFailure(error: Error)
}

public struct RequestHeader {
    public static var defatult: [String : String] {
        var headers = [String : String]()
        headers["iOS-Version"] = AppConfigure.systemVersion
        headers["Device-Mode"] = AppConfigure.deviceModel
        headers["App-Version"] = AppConfigure.appVersion
        headers["Content-Type"] = "application/json"
        return headers
    }
}
