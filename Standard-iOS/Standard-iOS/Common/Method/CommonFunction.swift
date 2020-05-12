//
//  CommonFunction.swift
//  YunZhouCommon
//
//  Created by James on 2018/6/7.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import UIKit

public struct CommonFunction {
    public static func makeTelephoneCall(_ phone: String) {
        do {
            let url = try URL(string: "tel:" + phone).unwrap()
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } catch {
            Logger.failure.error(error)
        }
    }
    
}

private let databasePath: String = "com.safety-saas.db.path"

public class DatabaseLogic {
    
    public static func doConnect(_ path: String) {
        UserLogicUtily.updateDatabasePath(path)
        DatabaseManager.shared.doConnection(path)
        UserLogicUtily.doDatabaseTableRegist()
        DatabaseManager.shared.migrateTables()
    }
    
    public static func disconnect() {
        UserLogicUtily.updateDatabasePath(nil)
        DatabaseManager.shared.disconnect()
    }
    
    public static func connectToLastDatabase() -> Bool {
        do {
            let path = try UserLogicUtily.queryDatabasePath().unwrap()
            let isConnected = DatabaseManager.shared.doConnection(path)
            UserLogicUtily.doDatabaseTableRegist()
            return isConnected
        } catch { return false }
    }
    
}

fileprivate struct UserLogicUtily {
    fileprivate static func updateDatabasePath(_ path: String?) {
        UserDefaults.standard[databasePath] = path
        UserDefaults.standard.synchronize()
    }
    
    fileprivate static func queryDatabasePath() -> String? {
        let path = UserDefaults.standard[databasePath]
        return try? targetResult(path)
    }
    
    fileprivate static func doDatabaseTableRegist() {
        
        DatabaseRegister.excuteProtocols()
    }
}
