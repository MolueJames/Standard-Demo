//
//  ReportService.swift
//  Standard-iOS
//
//  Created by MolueJames on 2020/4/15.
//  Copyright © 2020 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum ReportServicePath {
    case history
    case summary
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .history:
            return "/certi_auth/order/\(orderId)/reportHistory"
        case .summary:
            return "/certi_auth/order/\(orderId)/reportSummary"
        }
    }
}

public struct ReportService {
    // MARK: 生产安全事故记录
    public static func queryHistory(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = ReportServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = ReportServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = ReportServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = ReportServicePath.history.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    // MARK: 生产安全事故总结
    public static func querySummary(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = ReportServicePath.summary.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertSummary(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = ReportServicePath.summary.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateSummary(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = ReportServicePath.summary.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteSummary(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = ReportServicePath.summary.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
}
