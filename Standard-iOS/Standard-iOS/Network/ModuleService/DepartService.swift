//
//  DepartService.swift
//  Standard-iOS
//
//  Created by James on 2019/10/28.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum DepartServicePath {
    case execute
    case update
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .execute:
            return "/certi_auth/order/\(orderId)/departExecute"
        case .update:
            return "/certi_auth/order/\(orderId)/departUpdate"
        }
    }
}

public struct DepartService {
    //MARK: 责任评审更新
    public static func queryUpdate(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DepartServicePath.update.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateUpdate(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DepartServicePath.update.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 部门执行情况
    public static func queryExecute(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DepartServicePath.execute.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateExecute(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DepartServicePath.execute.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
}
