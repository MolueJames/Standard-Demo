//
//  YunZhouResponseHandler.swift
//  YunZhouNetwork
//
//  Created by James on 2018/5/22.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

public class ResponseHandler {
    
    var options: JSONSerialization.ReadingOptions
    
    var success: TargetClosure<Any?>?
    
    var failure: TargetClosure<Error>?
    
    var delegate: ActivityDelegate?
    
    var requestQueue: DispatchQueue
    
    public init(_ request: DispatchQueue, _ options: JSONSerialization.ReadingOptions, _ delegate: ActivityDelegate? = nil) {
        self.requestQueue = request
        self.delegate = delegate
        self.options = options
    }
    
    public func handleResponse(with response: HTTPURLResponse?, _ error: Error?, _ data: Data?) {
        self.requestQueue.async {
            let result = self.handleResponse(with: response, data, error)
            NetworkLogger.response(with: response, result: result)
            self.handleServiceResult(result)
        }
    }
    
    private func handleServiceResult(_ result: ServiceResponse) {
        switch result {
        case .resultSuccess(let result):
            self.delegate?.networkActivitySuccess()
            self.success?(result)
        case .resultFailure(let result):
            self.delegate?.networkActivityFailure(error: result)
            self.failure?(result)
        }
    }
    
    private func handleResponse(with response: HTTPURLResponse?, _ data: Data?, _ error: Error?) -> ServiceResponse {
        if let error = error { return .resultFailure(result: error) }
        switch self.validateResponse(response, data: data) {
        case .reponseSuccess(let data):
            return self.reponseSuccessHandler(data)
        case .authenticateFailure:
            return self.authenticateFailureHandler()
        case .requestIsNotExisted:
            return self.requestIsNotExistedHandler()
        case .bussinessError(let data):
            return self.bussinessErrorHandler(data)
        }
    }
    
    private func requestIsNotExistedHandler() -> ServiceResponse {
        let error = StatusError.requestIsNotExisted
        return ServiceResponse.resultFailure(result: error)
    }
    
    private func authenticateFailureHandler() -> ServiceResponse {
        let name = UserNotification.need_login.toName()
        NotificationCenter.default.post(name: name, object: nil)
        let error = StatusError.authenticateFailure
        return ServiceResponse.resultFailure(result: error)
    }
    
    private func bussinessErrorHandler(_ data: Data?) -> ServiceResponse {
        do {
            let result = try self.transferJson(with: data)
            let error = StatusError.bussinessError(result: result)
            return ServiceResponse.resultFailure(result: error)
        } catch {
            return ServiceResponse.resultFailure(result: error)
        }
    }
    
    private func reponseSuccessHandler(_ data: Data?) -> ServiceResponse {
        let result = try? self.transferJson(with: data)
        return ServiceResponse.resultSuccess(result: result)
    }
    
    private func transferJson(with data: Data?) throws -> Any {
        do {
            let data = try data.unwrap()
            return try JSONSerialization.jsonObject(with: data, options: self.options)
        } catch {
            throw StatusError.transferJsonFailure
        }
    }
    
    private func validateResponse(_ response: HTTPURLResponse?, data: Data?) -> ResponseStatus {
        switch response?.statusCode {
        case 200, 201, 204:
            return ResponseStatus.reponseSuccess(data: data)
        case 401:
            return ResponseStatus.authenticateFailure
        case 404:
            return ResponseStatus.requestIsNotExisted
        default:
            return ResponseStatus.bussinessError(data: data)
        }
    }
}

public extension DataRequest {
    func handleResponse(with handler: ResponseHandler) {
        let operation = BlockOperation.init {
            handler.handleResponse(with: self.response, self.delegate.error, self.delegate.data)
        }
        self.delegate.queue.addOperation(operation)
    }
}

private enum ResponseStatus {
    case authenticateFailure
    case requestIsNotExisted
    case bussinessError(data: Data?)
    case reponseSuccess(data: Data?)
}

public enum ServiceResponse : CustomDebugStringConvertible {
    case resultFailure(result: Error)
    case resultSuccess(result: Any?)
    
    public var debugDescription: String {
        switch self {
        case .resultSuccess(let result):
            if let result = result as? Dictionary<String, Any> {
                let message = result.jsonString()
                return message.value()
            } else if let result = result as? Array<Any> {
                let message = result.jsonString()
                return message.value()
            } else {
                return result.debugDescription
            }
        case .resultFailure(let result):
            return result.localizedDescription
        }
    }
}

public enum StatusError: LocalizedError {
    
    case authenticateFailure
    case requestIsNotExisted
    case transferJsonFailure
    case mapperResponseError
    case bussinessError(result: Any?)
    
    public var errorDescription: String? {
        switch self {
        case .authenticateFailure:
            return "授权超时,请重新登录"
        case .requestIsNotExisted:
            return "您访问的数据不存在!"
        case .transferJsonFailure:
            return "服务器返回数据异常!"
        case .mapperResponseError:
            return "服务器数据映射出错!"
        case .bussinessError(let result):
            return handleErrorResult(result: result)
        }
    }
    
    func handleErrorResult(result: Any?) -> String {
        do {
            let response: [String: Any] = try targetResult(result)
            let jsonString = response.jsonString(prettify: false)
            return try jsonString.unwrap()
        } catch { return "服务器发生了未知错误" }
    }
}
