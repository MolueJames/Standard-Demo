//
//  AppDocument.swift
//  Standard-iOS
//
//  Created by James on 2019/3/25.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation

fileprivate let single = AppDocument()

public class AppDocument {
    public static var shared: AppDocument {
        return single
    }
    
    var orderId: String = "18"
}
