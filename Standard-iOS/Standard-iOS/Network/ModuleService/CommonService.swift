//
//  CommonService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/18.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum CommonServicePath {
    case category
    case accident
    case training
    case operate
    case warning
    case special
    case inspect
    case system
    case depart
    case plants
    case device
    case manage
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .category:
            return "/certi_auth/order/\(orderId)/threatDetails"
        case .accident:
            return "/certi_auth/order/\(orderId)/accidents"
        case .warning:
            return "/certi_auth/order/\(orderId)/alarmingSigns"
        case .special:
            return "/certi_auth/order/\(orderId)/specialOperations"
        case .inspect:
            return "/certi_auth/order/\(orderId)/commonInspect"
        case .training:
            return "/certi_auth/order/\(orderId)/educationTrainings"
        case .depart:
            return "/certi_auth/order/\(orderId)/organization"
        case .plants:
            return "/certi_auth/order/\(orderId)/defaultPlants"
        case .device:
            return "/certi_auth/order/\(orderId)/defaultDevice"
        case .operate:
            return "/certi_auth/order/\(orderId)/legalsOperateItem"
        case .manage:
            return "/certi_auth/order/\(orderId)/systemManage"
        case .system:
            return "/certi_auth/order/\(orderId)/systemManage"
        }
    }
}

public struct CommonService {
    
    //MARK: 隐患类别
    public static func queryRiskCategory() -> AppDataRequest {
        let path: String = CommonServicePath.category.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    //MARK: 事故类型
    public static func queryAccidentType() -> AppDataRequest {
        let path: String = CommonServicePath.accident.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    //MARK: 警示标示
    public static func queryWarningType() -> AppDataRequest {
        let path: String = CommonServicePath.warning.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    //MARK: 特种人员
    public static func querySpecialType() -> AppDataRequest {
        let path: String = CommonServicePath.special.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    //MARK: 教育培训
    public static func queryTrainingType() -> AppDataRequest {
        let path: String = CommonServicePath.training.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    //MARK: 常用配置列表
    public static func queryGenericDepart() -> AppDataRequest {
        let path: String = CommonServicePath.depart.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    public static func queryGenericPlants() -> AppDataRequest {
        let path: String = CommonServicePath.plants.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    public static func queryGenericDanger() -> AppDataRequest {
        let path: String = CommonServicePath.device.generatePath()
        let paramter: [String : Any] = ["type" : "special"]
        return AppDataRequest(parameter: paramter, method: .get, path: path)
    }
    
    public static func queryGenericNormal() -> AppDataRequest {
        let path: String = CommonServicePath.device.generatePath()
        let paramter: [String : Any] = ["type" : "normal"]
        return AppDataRequest(parameter: paramter, method: .get, path: path)
    }
    
    public static func queryGenericInspect() -> AppDataRequest {
        let path: String = CommonServicePath.inspect.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    public static func queryOperateSystem() -> AppDataRequest {
        let path: String = CommonServicePath.operate.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    public static func queryManageSystem() -> AppDataRequest {
        let path: String = CommonServicePath.operate.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    //MARK: 安全管理制度
    public static func queryManageEntity(with parameter: [String: Any]?) -> AppDataRequest {
        let path: String = CommonServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateManageEntity(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CommonServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func querySelectEntity(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = CommonServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
}

