//
//  CollectService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum CollectServicePath {
    case employ
    case plants
    case depart
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .employ:
            return "/certi_auth/order/\(orderId)/employ"
        case .plants:
            return "/certi_auth/order/\(orderId)/plants"
        case .depart:
            return "/certi_auth/order/\(orderId)/depart"
        }
    }
}

public struct CollectService {
    
    //MARK: 企业员工信息
    public static func queryEmploy(with parameter: [String : Any]? = nil) -> AppDataRequest {
        let path: String = CollectServicePath.employ.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertEmploy(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.employ.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateEmploy(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.employ.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteEmploy(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.employ.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 企业厂区位置
    public static func queryPlants(with parameter: [String : Any]? = nil) -> AppDataRequest {
        let path: String = CollectServicePath.plants.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertPlants(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.plants.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updatePlants(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.plants.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deletePlants(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.plants.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 企业组织部门
    public static func queryDepart(with parameter: [String : Any]? = nil) -> AppDataRequest {
        let path: String = CollectServicePath.depart.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertDepart(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.depart.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateDepart(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.depart.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteDepart(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = CollectServicePath.depart.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
}
