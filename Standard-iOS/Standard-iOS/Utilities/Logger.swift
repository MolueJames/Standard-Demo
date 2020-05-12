//
//  YunZhouLogger.swift
//  YunZhouUtilities
//
//  Created by James on 2018/4/25.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation

public enum Logger: String {
    case warning = "⚠️"
    case success = "✅"
    case failure = "❎"
    case network = "⛅"
    case surface = "🎬"
    case dealloc = "♻️"
    case database = "📚"
    
    public func message<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) -> Void? {
        return LogUtility.Void.doLog(message, raw: self, file: file, method: method, line: line)
    }
    
    public func voidLog(file: String = #file, method: String = #function, line: Int = #line) -> Void {
        let filePath: String = "\((file as NSString).lastPathComponent)"
        print("\(filePath)-Line:\(line)-Method:\(method) \(self.rawValue): has nil value")
    }
    
    public func error<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) -> Void? {
        #if DEBUG
            return LogUtility.Never.doLog(message, raw: self, file: file, method: method, line: line)
        #else
            return LogUtility.Void.doLog(message, raw: self, file: file, method: method, line: line)
        #endif
    }
    
    public func returnNil<T, R> (_ message: T, file: String = #file, method: String = #function, line: Int = #line) -> R? {
        #if DEBUG
            return LogUtility.Never.doLog(message, raw: self, file: file, method: method, line: line)
        #else
            return LogUtility.Void.doLog(message, raw: self, file: file, method: method, line: line)
        #endif
    }
    
    public func allowNil<T, R> (_ message: T, file: String = #file, method: String = #function, line: Int = #line) -> R? {
        return LogUtility.Void.doLog(message, raw: self, file: file, method: method, line: line)
    }
}

fileprivate enum LogUtility {
    case Never
    case Void
    
    func doLog<T, R>(_ message: T, raw: Logger, file: String, method: String, line: Int) -> R? {
        let filePath: String = "\((file as NSString).lastPathComponent)"
        self.doPrint("\(filePath)-Line:\(line)-Method:\(method) \(raw.rawValue): \(message)")
        return nil
    }
    
    private func doPrint(_ message: String) {
        switch self {
        case .Never: fatalError(message)
        case .Void: print(message)
        }
    }
}
