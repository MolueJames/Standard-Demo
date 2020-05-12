//
//  InvestService.swift
//  Standard-iOS
//
//  Created by James on 2019/10/21.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum InvestServicePath {
    case planned
    case history
    case applied
    case punish
    case reward
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .planned:
            return "/certi_auth/order/\(orderId)/investPlanned"
        case .history:
            return "/certi_auth/order/\(orderId)/investHistory"
        case .applied:
            return "/certi_auth/order/\(orderId)/investApplied"
        case .punish:
            return "/certi_auth/order/\(orderId)/investPunish"
        case .reward:
            return "/certi_auth/order/\(orderId)/investReward"
        }
    }
}

public struct InvestService {
    //MARK: 安全费用投入计划
    public static func queryPlanned(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = InvestServicePath.planned.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updatePlanned(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.planned.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全生产费用记录
    public static func queryHistory(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = InvestServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全生产处罚记录
    public static func queryPunish(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = InvestServicePath.punish.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertPunish(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.punish.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updatePunish(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.punish.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deletePunish(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.punish.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全生产奖励记录
    public static func queryReward(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = InvestServicePath.reward.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertReward(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.reward.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateReward(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.reward.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteReward(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.reward.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全费用申请记录
    public static func queryApplied(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = InvestServicePath.applied.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertApplied(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.applied.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateApplied(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.applied.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteApplied(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = InvestServicePath.applied.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
}
