//
//  LegalsService.swift
//  Standard-iOS
//
//  Created by James on 2019/10/28.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum LegalsServicePath {
    case legalsOperateItem
    case legalsOperate
    case legalsManageItem
    case legalsManage
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .legalsOperateItem:
            return "/certi_auth/order/\(orderId)/legalsOperateItem"
        case .legalsOperate:
            return "/certi_auth/order/\(orderId)/legalsOperate"
        case .legalsManageItem:
            return "/certi_auth/order/\(orderId)/legalsManageItem"
        case .legalsManage:
            return "/certi_auth/order/\(orderId)/legalsManage"
        }
    }
}

public struct LegalsService {
    //MARK: 管理制度评估修订
    public static func queryManageItem(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = LegalsServicePath.legalsManageItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateManageItem(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = LegalsServicePath.legalsManageItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func queryManageEntity() -> AppDataRequest {
        let path: String = LegalsServicePath.legalsManage.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    public static func updateManageEntity(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = LegalsServicePath.legalsManage.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 操作规程评估修订
    public static func queryOperateItem(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = LegalsServicePath.legalsOperateItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateOperateItem(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = LegalsServicePath.legalsOperateItem.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func queryOperateEntity() -> AppDataRequest {
        let path: String = LegalsServicePath.legalsOperate.generatePath()
        return AppDataRequest(parameter: nil, method: .get, path: path)
    }
    
    public static func updateOperateEntity(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = LegalsServicePath.legalsOperate.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
}
