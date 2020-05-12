//
//  YunZhouDatabaseRegister.swift
//  YunZhouDatabase
//
//  Created by James on 2018/5/5.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
public class DatabaseRegister {
    private static var list = [DatabaseProtocol.Type]()
    private static let databaseLock = NSLock()
    
    public static func addTarget(_ target: DatabaseProtocol.Type) {
        databaseLock.lock()
        list.append(target)
        databaseLock.unlock()
    }
    
    public static func excuteProtocols () {
        databaseLock.lock()
        list.forEach { (aProtocol) in
            aProtocol.createOperation()
        }
        databaseLock.unlock()
    }
}
