//
//  AppError.swift
//  Standard-iOS
//
//  Created by James on 2019/11/20.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Bugly

public struct AppError: Error, CustomStringConvertible {
    
    public var description: String {
        return _description
    }
    
    public init(file: String = #file, function: String = #function, line: Int = #line) {
        _description = "error at " + (file as NSString).lastPathComponent + ":\(line)"
        Bugly.reportError(self)
    }
    
    private let _description: String
}

public struct MError: LocalizedError {
    
    private(set) var message: String
    
    public init(message: String) {
        self.message = message
        Bugly.reportError(self)
    }
    
    public var errorDescription: String? {
        return self.message
    }
}


