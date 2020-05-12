//
//  MapperExtensions.swift
//  Standard-iOS
//
//  Created by James on 2019/9/17.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import ObjectMapper

public extension BaseMappable { // allow value is nil
    
    /// Returns the JSON Dictionary for the object
    func toJson() -> [String: Any] {
        return Mapper().toJson(self)
    }
    
    /// Returns the JSON String for the object
    func toJsonString(prettyPrint: Bool = false) -> String? {
        return Mapper().toJsonString(self, prettyPrint: prettyPrint)
    }
}

extension Mapper { // allow value is nil
    
    ///Maps an object that conforms to Mappable to a JSON dictionary <String, Any>
    public func toJson(_ object: N) -> [String: Any] {
        var mutableObject = object
        let map = Map(mappingType: .toJSON, JSON: [:], context: context, shouldIncludeNilValues: true)
        mutableObject.mapping(map: map)
        return map.JSON
    }
    /// Maps an Object to a JSON string with option of pretty formatting
    public func toJsonString(_ object: N, prettyPrint: Bool = false) -> String? {
        let JSONDict = toJson(object)
        
        return Mapper.toJSONString(JSONDict as Any, prettyPrint: prettyPrint)
    }
}
