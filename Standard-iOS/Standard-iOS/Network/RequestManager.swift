//
//  YunZhouRequestManager.swift
//  YunZhouNetwork
//
//  Created by James on 2018/5/30.
//  Copyright ©2018年 YunZhou. All rights reserved.
//
import Foundation
import Alamofire
import BoltsSwift
import ObjectMapper

public typealias TargetClosure<Target> = (Target) -> Void

open class RequestManager {
    private(set) weak var delegate: ActivityDelegate?
    private(set) var requestQueue: DispatchQueue
    private var options: JSONSerialization.ReadingOptions
    
    public init(delegate: ActivityDelegate? = nil, queue: DispatchQueue! = .main, options: JSONSerialization.ReadingOptions! = .allowFragments) {
        self.requestQueue = queue
        self.options = options
        self.delegate = delegate
    }
    
    @discardableResult
    public func doResume(with request: AppDataRequest) -> Task<Any?> {
        let taskSource = TaskCompletionSource<Any?>()
        let handler = self.createHander(taskSource, request: request)
        let dataRequest = self.createDataRequest(with: request)
        dataRequest.handleResponse(with: handler)
        return taskSource.task
    }
    
    func handleSuccess(with result: Any?, request: AppDataRequest?) {
        do {
            let request = try request.unwrap()
            try request.success.unwrap()(result)
        } catch { Logger.network.message(error) }
    }
    
    func handleFailure(with result: Error, request: AppDataRequest?) {
        do {
            let request = try request.unwrap()
            try request.failure.unwrap()(result)
        } catch { Logger.network.message(error) }
    }
    
    func createHander(_ taskSource: TaskCompletionSource<Any?>, request: AppDataRequest) -> ResponseHandler {
        let handler = ResponseHandler(self.requestQueue, self.options, self.delegate)
        handler.success = { (result) in
            self.handleSuccess(with: result, request: request)
            taskSource.set(result: result)
        }
        handler.failure = { (error) in
            self.handleFailure(with: error, request: request)
            taskSource.set(error: error)
        }
        return handler
    }
    
    private func createDataRequest(with request: AppDataRequest) -> DataRequest {
        SessionManager.default.adapter = AppRequestAdapter()
        return SessionManager.default.request(with: request, delegate: delegate, queue: requestQueue)
    }
}

