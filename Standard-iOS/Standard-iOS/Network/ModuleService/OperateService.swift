//
//  OperateService.swift
//  Standard-iOS
//
//  Created by James on 2019/10/28.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum OperateServicePath {
    case provideItem
    case standard
    case provide
    case procure
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .provideItem:
            return "/certi_auth/order/\(orderId)/operateProvideItem"
        case .standard:
            return "/certi_auth/order/\(orderId)/operateStandard"
        case .provide:
            return "/certi_auth/order/\(orderId)/operateProvide"
        case .procure:
            return "/certi_auth/order/\(orderId)/operateProcure"
        }
    }
}

public struct OperateService {
    //MARK: 获取劳保用品方法标准
    public static func queryStandard(with parameter: [String : Any]? = nil) -> AppDataRequest {
        let path: String = OperateServicePath.standard.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateStandard(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.standard.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 劳保用品配发
    public static func queryProvide(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = OperateServicePath.provide.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertProvideItem(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.provideItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateProvideItem(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.provideItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteProvideItem(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.provideItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 劳保用品采购记录
    public static func queryProcure(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = OperateServicePath.procure.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertProcure(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.procure.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateProcure(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.procure.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteProcure(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = OperateServicePath.procure.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
}
