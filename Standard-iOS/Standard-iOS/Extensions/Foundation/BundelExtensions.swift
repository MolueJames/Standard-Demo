//
//  BundelExtensions.swift
//  YunZhouUtilities
//
//  Created by James on 2018/5/13.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation

public extension Bundle {
    static func create(module: String) -> Bundle? {
        guard let path = Bundle.main.path(forResource: module, ofType: "framework")  else {return nil}
        guard let bundle = Bundle.init(path: path) else {return nil}
        return bundle
    }
}
