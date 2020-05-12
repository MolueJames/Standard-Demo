//
//  TargetTypeExtension.swift
//  YunZhouUtilities
//
//  Created by James on 2018/9/14.
//  Copyright ©2018年 YunZhou. All rights reserved.
//
import Foundation
import UIKit

func targetResult<T>(_ value: Any?, file: String = #file, function: String = #function, line: Int = #line) throws -> T {
    if let value = value as? T { return value }
    throw AppError(file: file, function: function, line: line)
}

public protocol TargetHelper {}

public extension TargetHelper where Self: Any {
    func toTarget<T> (file: String = #file, function: String = #function, line: Int = #line) throws -> T {
        if let value = self as? T { return value }
        throw AppError(file: file, function: function, line: line)
    }
}

extension NSObject: TargetHelper {}
extension CGPoint: TargetHelper {}
extension CGRect: TargetHelper {}
extension CGSize: TargetHelper {}
extension CGVector: TargetHelper {}
extension Array: TargetHelper {}
extension Dictionary: TargetHelper{}
extension String: TargetHelper{}
