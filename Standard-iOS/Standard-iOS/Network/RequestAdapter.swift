//
//  YunZhouRequestAdapter.swift
//  Standard-iOS
//
//  Created by James on 2019/9/7.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

public struct AppRequestAdapter: RequestAdapter {
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request: URLRequest = urlRequest
        let token = "UserLoginEntity.queryCurrent()?.token"
        request.setValue(token, forHTTPHeaderField: "token")
        NetworkLogger.request(with: request)
        return request
    }
}
