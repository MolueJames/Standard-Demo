//
//  TargetService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum TargetServicePath {
    case meeting
    case resolve
    case assess
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .meeting:
            return "/certi_auth/order/\(orderId)/targetMeeting"
        case .resolve:
            return "/certi_auth/order/\(orderId)/targetResolve"
        case .assess:
            return "/certi_auth/order/\(orderId)/targetAssess"
        }
    }
}

public struct TargetService {
    //MARK: 安全会议记录
    public static func queryMeeting(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TargetServicePath.meeting.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertMeeting(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TargetServicePath.meeting.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateMeeting(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TargetServicePath.meeting.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteMeeting(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TargetServicePath.meeting.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全目标分解
    public static func queryResolve(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TargetServicePath.resolve.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateResolve(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TargetServicePath.resolve.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全目标考核
    public static func queryAssess(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = TargetServicePath.assess.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateAssess(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = TargetServicePath.assess.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
}
