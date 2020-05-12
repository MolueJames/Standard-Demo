//
//  YunZhouNetworkRequest.swift
//  YunZhouNetwork
//
//  Created by James on 2018/5/22.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

public class AppDataRequest {
    var parameter: [String: Any]?
    var method: HTTPMethod
    var encoding: ParameterEncoding = URLEncoding.default
    var components: URLComponents?
    var headers: HTTPHeaders?
    private(set) var failure: TargetClosure<Error>?
    private(set) var success: TargetClosure<Any?>?
    
    public init(baseURL: String! = HTTPConfigure.baseURL, parameter: [String: Any]?, method: HTTPMethod, path: String, headers: HTTPHeaders? = RequestHeader.defatult, encoding: ParameterEncoding! = URLEncoding.default) {
        defer { NetworkLogger.request(with: parameter) }
        let urlPath: String = path.hasPrefix("/") ? path : "/" + path
        self.components = URLComponents(string: baseURL + urlPath)
        self.parameter = parameter
        self.encoding = encoding
        self.headers = headers
        self.method = method
    }
    
    @discardableResult
    public func handleSuccessResponse(_ success: TargetClosure<Any?>?) -> AppDataRequest {
        self.success = success
        return self
    }
    
    @discardableResult
    public func handleFailureResponse(_ failure: TargetClosure<Error>?) -> AppDataRequest {
        self.failure = failure
        return self
    }
}

public extension SessionManager {
    
    func request(with request: AppDataRequest, delegate: ActivityDelegate? = nil, queue: DispatchQueue) -> DataRequest {
        do {
            let requestURL = try request.components.unwrap().asURL()
            return SessionManager.default.request(requestURL, method: request.method, parameters: request.parameter, encoding: request.encoding, headers: request.headers, delegate: delegate, requestQueue: queue)
        } catch { fatalError(error.localizedDescription) }
    }
    
    func request(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding, headers: HTTPHeaders? = nil, delegate: ActivityDelegate? = nil, requestQueue: DispatchQueue)-> DataRequest {
        requestQueue.async { delegate?.networkActivityStarted() }
        return request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
}


