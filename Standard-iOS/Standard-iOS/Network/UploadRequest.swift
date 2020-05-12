//
//  UploadFileService.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/4/19.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire
import BoltsSwift

public typealias MultipartFormDataResult = SessionManager.MultipartFormDataEncodingResult

fileprivate extension MultipartFormData {
    func append(with body: FormProtocol) {
        append(body.data, withName: body.name, fileName: body.file, mimeType: body.type)
    }
}

public protocol FormProtocol {
    var name: String { get set }
    var file: String { get set }
    var type: String { get set }
    var data: Data { get set }
}

public struct FormBody: FormProtocol {
    public var file: String = Date().string() + ".jpg"
    public var type: String = "image/jpg"
    public var name: String = "file"
    public var data: Data
    
    init(_ data: Data) {
        self.data = data
    }
}

public class AppUploadRequest {
    private(set) var failure: TargetClosure<Error>?
    private(set) var success: TargetClosure<Any?>?
    private(set) var formBody: FormProtocol
    private(set) var urlPath: String
    
    public init(queue: DispatchQueue! = .main, urlPath: String, formBody: FormProtocol) {
        self.formBody = formBody
        self.urlPath = urlPath
    }
    
    public func handleResult(_ result: MultipartFormDataResult, handler: ResponseHandler) {
        if case let .success(upload, _, _) = result {
            upload.handleResponse(with: handler)
        }
        if case let .failure(error) = result {
            self.failure?(error)
        }
    }
    
    public func handleSuccessResponse(_ success: TargetClosure<Any?>?) {
        self.success = success
    }
    
    public func handleFailureResponse(_ failure: TargetClosure<Error>?) {
        self.failure = failure
    }
}

public class UploadManager {
    private(set) var delegate: ActivityDelegate?
    private(set) var queue: DispatchQueue
    
    public init(delegate: ActivityDelegate? = nil, queue: DispatchQueue! = .main) {
        self.delegate = delegate
        self.queue = queue
    }
    
    @discardableResult
    func doResume(with request: AppUploadRequest) -> Task<Any?> {
        self.requestStart(self.queue, delegate: self.delegate)
        let taskSource = TaskCompletionSource<Any?>()
        let handler = self.createHander(taskSource, request: request)
        Alamofire.upload(multipartFormData: { (formData) in
            formData.append(with: request.formBody)
        }, to: request.urlPath, method: .post) { (result) in
            request.handleResult(result, handler: handler)
        }
        return taskSource.task
    }
    
    func requestStart(_ requestQueue: DispatchQueue, delegate: ActivityDelegate?) {
        requestQueue.async { delegate?.networkActivityStarted() }
    }
    
    func handleSuccess(with result: Any?, request: AppUploadRequest?) {
        do {
            let request = try request.unwrap()
            try request.success.unwrap()(result)
        } catch { Logger.network.message(error) }
    }
    
    func handleFailure(with result: Error, request: AppUploadRequest?) {
        do {
            let request = try request.unwrap()
            try request.failure.unwrap()(result)
        } catch { Logger.network.message(error) }
    }
    
    func createHander(_ taskSource: TaskCompletionSource<Any?>, request: AppUploadRequest) -> ResponseHandler {
        let handler = ResponseHandler(self.queue, .allowFragments, self.delegate)
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
}

public extension UploadRequest {
    //TODO...
}
