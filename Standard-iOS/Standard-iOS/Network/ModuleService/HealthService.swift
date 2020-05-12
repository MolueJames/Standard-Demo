//
//  HealthService.swift
//  Standard-iOS
//
//  Created by MolueJames on 2020/4/12.
//  Copyright © 2020 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum HealthServicePath {
    case manage
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .manage:
            return "/certi_auth/order/\(orderId)/healthManage"
        }
    }
}

public struct HealthService {
    // MARK: 职业病危害管理
    public static func queryManage(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = HealthServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertManage(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = HealthServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateManage(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = HealthServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteManage(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = HealthServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
}
