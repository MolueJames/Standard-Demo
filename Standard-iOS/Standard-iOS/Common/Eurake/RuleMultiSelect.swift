//
//  MultiSelectRule.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/6/5.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Eureka

public struct RuleMultiSelect: RuleType {
    public init(msg: String, id: String? = nil) {
        self.validationError = ValidationError(msg: msg)
        self.id = id
    }
    
    public var id: String?
    public var validationError: ValidationError
    
    public func isValid(value: Set<String>?) -> ValidationError? {
        guard let value = value, value.count > 0 else {
            return validationError
        }
        return Logger.surface.allowNil("")
    }
}
