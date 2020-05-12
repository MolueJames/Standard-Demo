//
//  YunZhouResultListModel.swift
//  YunZhouNetwork
//
//  Created by James on 2018/12/12.
//  Copyright © 2018YunZhou. All rights reserved.
//

import Foundation
import ObjectMapper

public class ListItem<T: Mappable>: Mappable {
    public required init?(map: Map) {
        pagesize <- map["pageSize"]
        previous <- map["previous"]
        results  <- map["results"]
        count    <- map["count"]
        next     <- map["next"]
    }
    
    public func mapping(map: Map) {
        pagesize >>> map["pageSize"]
        next >>> map["page"]
    }
    
    public init(_ pagesize: Int = 24) {
        self.pagesize = pagesize
    }
    
    public var pagesize: Int = 0
    public var count: Int?
    public var next: Int? = 1
    public var previous: Int?
    public var results: [T]?
    
    public func append(with item: ListItem<T>?) throws {
        do {
            let newItem = try item.unwrap()
            let results = try newItem.results.unwrap()
            self.results?.append(contentsOf: results)
            self.next = newItem.next
        } catch { throw error }
    }
    
    public func replace(with result: T, index: Int) {
        self.results?[index] = result
    }
}
