//
//  MonitorService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum MonitorServicePath {
    case result
    case factor
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .result:
            return "/certi_auth/order/\(orderId)/monitorResult"
        case .factor:
            return "/certi_auth/order/\(orderId)/monitorFactor"
        }
    }
}

public struct MonitorService {
    //MARK: 风险点监控
    public static func queryResult(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = MonitorServicePath.result.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertResult(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = MonitorServicePath.result.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateResult(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = MonitorServicePath.result.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteResult(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = MonitorServicePath.result.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 风险因素
    public static func insertFactor(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = MonitorServicePath.factor.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateFactor(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = MonitorServicePath.factor.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteFactor(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = MonitorServicePath.factor.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
}
