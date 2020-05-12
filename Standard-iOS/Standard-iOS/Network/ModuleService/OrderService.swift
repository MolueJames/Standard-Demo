//
//  OrderService.swift
//  Standard-iOS
//
//  Created by James on 2019/9/12.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import Alamofire

fileprivate enum OrderServicePath {
    case order
    
    fileprivate func generatePath() -> String {
        return "/certi_auth/order"
    }
}

public struct OrderService {
    public static func queryOrder(with parameter: [String : Any]?) -> AppDataRequest {
        let path: String = OrderServicePath.order.generatePath()
        return AppDataRequest(parameter: parameter, method: .get, path: path)
    }
}
