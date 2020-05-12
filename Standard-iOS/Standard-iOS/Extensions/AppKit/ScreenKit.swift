//
//  DeviceKit.swift
//  YunZhouUtilities
//
//  Created by James on 2018/10/14.
//  Copyright © 2018YunZhou. All rights reserved.
//
import Foundation
import UIKit

public enum ScreenKit {
    case inch3_5
    case inch4_0
    case inch4_7
    case inch5_5
    case inch5_8
    case inch6_1
    case inch6_5
    case forIpad
}

public extension ScreenKit {
    static func current() -> ScreenKit {
        switch (UIScreen.main.currentMode?.size)! {
        case CGSize(width: 320, height: 480): return .inch3_5
        case CGSize(width: 320, height: 568): return .inch4_0
        case CGSize(width: 375, height: 667): return .inch4_7
        case CGSize(width: 1242, height: 2208): return .inch5_5
        case CGSize(width: 828, height: 1792): return .inch6_1
        case CGSize(width: 1125, height: 2436): return .inch5_8
        case CGSize(width: 1242, height: 2688): return .inch6_5
        default: return .forIpad
        }
    }
    
    static func navHeight() -> CGFloat {
        switch self.current() {
        case .inch6_5, .inch6_1, .inch5_8: return 88
        case .inch3_5, .inch4_0, .inch4_7, .inch5_5: return 64
        case .forIpad: return 70
        }
    }
}
