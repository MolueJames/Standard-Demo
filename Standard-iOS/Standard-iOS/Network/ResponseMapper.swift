//
//  YunZhouResponseMapper.swift
//  YunZhouNetwork
//
//  Created by James on 2018/5/25.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import ObjectMapper

private struct ResponseMapper {
    public static func handleResultToDict<Target: Mappable>(_ result: Any?) throws -> Target {
        do {
            return try Mapper<Target>().map(JSONObject: result).unwrap()
        } catch {
            throw StatusError.mapperResponseError
        }
    }
    
    public static func handleResultToList<Target: Mappable>(_ result: Any?) throws -> [Target] {
        do {
            let result: [[String: Any]] = try targetResult(result)
            return Mapper<Target>().mapArray(JSONArray: result)
        } catch {
            throw StatusError.mapperResponseError
        }
    }
}

public extension AppDataRequest {
    @discardableResult
    func handleSuccessResultToObjc<T: Mappable>(_ success: TargetClosure<T?>?) -> AppDataRequest {
        let resultClosure: TargetClosure<Any?> = { (result) in
            do {
                let response: T? = try ResponseMapper.handleResultToDict(result)
                try success.unwrap()(response)
            } catch {
                Logger.failure.error(error)
            }
        }
        self.handleSuccessResponse(resultClosure)
        return self
    }
    @discardableResult
    func handleSuccessResultToList<T: Mappable>(_ success: TargetClosure<[T]?>?) -> AppDataRequest {
        let resultClosure: TargetClosure<Any?> = { (result) in
            do {
                let response:[T]? = try ResponseMapper.handleResultToList(result)
                try success.unwrap()(response)
            } catch {
                Logger.failure.error(error)
            }
        }
        self.handleSuccessResponse(resultClosure)
        return self
    }
}

public extension AppUploadRequest {
    @discardableResult
    func handleSuccessResultToObjc<T: Mappable>(_ success: TargetClosure<T?>?) -> AppUploadRequest {
        let resultClosure: TargetClosure<Any?> = { (result) in
            do {
                let response: T? = try ResponseMapper.handleResultToDict(result)
                try success.unwrap()(response)
            } catch {
                Logger.failure.error(error)
            }
        }
        self.handleSuccessResponse(resultClosure)
        return self
    }
    @discardableResult
    func handleSuccessResultToList<T: Mappable>(_ success: TargetClosure<[T]?>?) -> AppUploadRequest {
        let resultClosure: TargetClosure<Any?> = { (result) in
            do {
                let response:[T]? = try ResponseMapper.handleResultToList(result)
                try success.unwrap()(response)
            } catch {
                Logger.failure.error(error)
            }
        }
        self.handleSuccessResponse(resultClosure)
        return self
    }
}
