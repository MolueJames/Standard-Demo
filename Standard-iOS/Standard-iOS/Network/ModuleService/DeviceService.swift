//
//  DeviceService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum DeviceServicePath {
    case special
    case device
    case unfire
    case detect
    case repair
    case keeped
    
    fileprivate func generatePath() -> String {
        let orderId: String = AppDocument.shared.orderId
        switch self {
        case .special:
            return "/certi_auth/order/\(orderId)/specialRepair"
        case .unfire:
            return "/certi_auth/order/\(orderId)/deviceUnfire"
        case .detect:
            return "/certi_auth/order/\(orderId)/deviceDetect"
        case .repair:
            return "/certi_auth/order/\(orderId)/deviceRepair"
        case .keeped:
            return "/certi_auth/order/\(orderId)/deviceKeeped"
        case .device:
            return "/certi_auth/order/\(orderId)/device"
        }
    }
}

public struct DeviceService {
    //MARK: 设备设施通用接口(普通设备和特种设备)
    public static func queryOrderDevice(parameter: [String : Any]? = nil) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    //MARK: 设备设施管理
    public static func queryNormal(with parameter: [String : Any]?) -> AppDataRequest {
        let parameter = ["type" : "normal"] + (parameter ?? [:])
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertNormal(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateNormal(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteNormal(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 特种设备管理
    public static func querySpecial(with parameter: [String : Any]?) -> AppDataRequest {
        let parameter = ["type" : "special"] + (parameter ?? [:])
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertSpecial(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateSpecial(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteSpecial(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.device.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    // MARK: 消防器材管理
    public static func queryUnfire(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DeviceServicePath.unfire.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertUnfire(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.unfire.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateUnfire(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.unfire.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteUnfire(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.unfire.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    
    //MARK: 安全设备管理
    public static func queryDetect(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DeviceServicePath.detect.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertDetect(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.detect.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateDetect(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.detect.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteDetect(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.detect.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    //MARK: 设备维修计划
    public static func queryRepair(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DeviceServicePath.repair.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertRepair(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.repair.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateRepair(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.repair.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteRepair(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.repair.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    //MARK: 设备保养计划
    public static func queryKeeped(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DeviceServicePath.keeped.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func insertKeeped(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.keeped.generatePath()
        return AppDataRequest(parameter: parameter, method: .post, path: path, encoding: JSONEncoding.default)
    }
    
    public static func updateKeeped(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.keeped.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
    
    public static func deleteKeeped(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.keeped.generatePath()
        return AppDataRequest(parameter: parameter, method: .delete, path: path, encoding: JSONEncoding.default)
    }
    //MARK: 特种设备维保
    public static func queryHistory(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = DeviceServicePath.special.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
    
    public static func updateHistory(with parameter: [String : Any]) -> AppDataRequest {
        let path: String = DeviceServicePath.special.generatePath()
        return AppDataRequest(parameter: parameter, method: .put, path: path, encoding: JSONEncoding.default)
    }
}
