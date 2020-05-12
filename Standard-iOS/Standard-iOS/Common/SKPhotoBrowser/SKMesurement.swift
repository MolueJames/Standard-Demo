//
//  SKMesurement.swift
//  SKPhotoBrowser
//
//  Created by 鈴木 啓司 on 2016/08/09.
//  Copyright © 2016年 suzuki_keishi. All rights reserved.
//

import Foundation
import UIKit

struct SKMesurement {
    static let isPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone
    static let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    static var screenHeight: CGFloat {
        return UIApplication.shared.preferredApplicationWindow?.bounds.height ?? UIScreen.main.bounds.height
    }
    static var screenWidth: CGFloat {
        return UIApplication.shared.preferredApplicationWindow?.bounds.width ?? UIScreen.main.bounds.width
    }
    static var screenScale: CGFloat {
        return UIScreen.main.scale
    }
    static var screenRatio: CGFloat {
        return screenWidth / screenHeight
    }
    static var isPhoneX: Bool {
        if isPhone && UIScreen.main.nativeBounds.height == 2436 {
           return true
        }
        return false
    }
}