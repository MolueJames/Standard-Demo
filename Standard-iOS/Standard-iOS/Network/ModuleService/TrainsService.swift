//
//  TrainsService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum TrainsServicePath {
    case history
    case special
    case operate
    case newPost
    case manage
    case safety
    case induct
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .history:
            return "/certi_auth/order/\(orderId)/trainsHistory"
        case .special:
            return "/certi_auth/order/\(orderId)/trainsSpecial"
        case .operate:
            return "/certi_auth/order/\(orderId)/trainsOperate"
        case .newPost:
            return "/certi_auth/order/\(orderId)/trainsNewPost"
        case .manage:
            return "/certi_auth/order/\(orderId)/trainsManage"
        case .safety:
            return "/certi_auth/order/\(orderId)/trainsSafety"
        case .induct:
            return "/certi_auth/order/\(orderId)/trainsnewpost"
        }
    }
}

public struct TrainsService {

    //MARK: 安全培训记录
    public static func queryHistory(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全人员培训
    public static func querySafety(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.safety.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertSafety(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.safety.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateSafety(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.safety.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteSafety(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.safety.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 特种人员培训
    public static func querySpecial(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.special.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertSpecial(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.special.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateSpecial(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.special.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteSpecial(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.special.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 操作规程培训
    public static func queryOperate(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.operate.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateOperate(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.operate.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func insertOperate(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.operate.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteOperate(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.operate.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全责任培训
    public static func queryManage(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateManage(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func insertManage(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteManage(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.manage.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 入职员工培训
    public static func queryInduct(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.induct.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateInduct(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.induct.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func insertInduct(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.induct.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteInduct(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.induct.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 转岗复工培训
    public static func queryNewpost(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TrainsServicePath.newPost.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateNewpost(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.newPost.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func insertNewpost(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.newPost.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteNewpost(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TrainsServicePath.newPost.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
}
