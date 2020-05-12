//
//  DangerService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum DangerServicePath {
    case invest
    case history
    case select
    case plan
    case task
    
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .history:
            return "/certi_auth/order/\(orderId)/inspectHistory"
        case .invest:
            return "/certi_auth/order/\(orderId)/dangerInvest"
        case .select:
            return ""
        case .plan:
            return "/certi_auth/order/\(orderId)/inspectPlan"
        case .task:
            return "/certi_auth/order/\(orderId)/inspectTask"
        }
    }
}

public struct DangerService {
    //MARK: 隐患排查清单
    public static func queryInvest(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertInvest(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateInvest(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteInvest(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 企业风险点检查
    public static func queryInspect(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func queryPosition(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updatePosition(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.invest.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    
    public static func queryPlan(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DangerServicePath.plan.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func selectPlan(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.plan.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updatePlan(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.plan.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deletePlan(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.plan.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    public static func insertPlan(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DangerServicePath.plan.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
}
