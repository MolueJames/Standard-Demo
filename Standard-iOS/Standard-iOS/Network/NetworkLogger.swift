//
//  NetworkLogger.swift
//  Standard-iOS
//
//  Created by James on 2019/12/6.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation

public struct NetworkLogger {
    public static func request(with request: URLRequest) {
        do {
            let headers = try request.allHTTPHeaderFields.unwrap()
            let json = headers.jsonString(prettify: true)
            try Logger.network.message(json.unwrap())
        } catch {}
        
        do {
            let urlPath = try request.url.unwrap().absoluteString
            Logger.network.message(urlPath)
        } catch {}
    }
    
    public static func request(with parameter: [String : Any]?) {
        do {
           let parameter = try parameter.unwrap()
           let json = parameter.jsonString(prettify: true)
           try Logger.network.message(json.unwrap())
       } catch { }
    }
    
    public static func response(with response: HTTPURLResponse?, result: ServiceResponse) {
        Logger.network.message(result.debugDescription)
        Logger.network.message(response?.statusCode)
    }
}
