//
//  ToJSON.swift
//  ObjectMapper
//
//  Created by Tristan Himmelman on 2014-10-13.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014-2018 Tristan Himmelman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

private func setValue(_ value: Any, map: Map) {
	setValue(value, key: map.currentKey!, checkForNestedKeys: map.keyIsNested, delimiter: map.nestedKeyDelimiter, dictionary: &map.JSON)
}

private func setValue(_ value: Any, key: String, checkForNestedKeys: Bool, delimiter: String, dictionary: inout [String : Any]) {
	if checkForNestedKeys {
		let keyComponents = ArraySlice(key.components(separatedBy: delimiter).filter { !$0.isEmpty }.map { $0 })
		setValue(value, forKeyPathComponents: keyComponents, dictionary: &dictionary)
	} else {
		dictionary[key] = value
	}
}

private func setValue(_ value: Any, forKeyPathComponents components: ArraySlice<String>, dictionary: inout [String : Any]) {
	guard let head = components.first else {
		return
	}

	let headAsString = String(head)
	if components.count == 1 {
		dictionary[headAsString] = value
	} else {
		var child = dictionary[headAsString] as? [String : Any] ?? [:]
		
		let tail = components.dropFirst()
		setValue(value, forKeyPathComponents: tail, dictionary: &child)

		dictionary[headAsString] = child
	}
}

internal final class ToJSON {
	
	class func basicType<N>(_ field: N, map: Map) {
		if let value = field as Any? , self.validate(value) {
			setValue(value, map: map)
        }
	}
    
    class func validate(_ value: Any?) -> Bool {
        return self.validateIsBasic(value)
            || self.validateIsList(value)
            || self.validateIsMap(value)
            || false
    }
    
    class func validateIsBasic(_ value: Any?) -> Bool {
        return value is NSNumber
            || value is Double
            || value is String
            || value is NSNull
            || value is Float
            || value is Bool
            || value is Int
    }
    
    class func validateIsList(_ value: Any?) -> Bool {
        return value is Array<Dictionary<String, Any>>
            || value is Array<NSNumber>
            || value is Array<Bool>
            || value is Array<Int>
            || value is Array<Double>
            || value is Array<Float>
            || value is Array<String>
            || value is Array<Any>
    }
    
    class func validateIsMap(_ value: Any?) -> Bool {
        return value is Dictionary<String, NSNumber>
            || value is Dictionary<String, String>
            || value is Dictionary<String, Double>
            || value is Dictionary<String, Float>
            || value is Dictionary<String, Bool>
            || value is Dictionary<String, Int>
            || value is Dictionary<String, Any>
    }
	
	class func optionalBasicType<N>(_ field: N?, map: Map) {
        if let field = field {
            basicType(field, map: map)
        } else if map.shouldIncludeNilValues {
            setValue(field, map: map)
        }
	}

	class func object<N: BaseMappable>(_ field: N, map: Map) {
		if let result = Mapper(context: map.context, shouldIncludeNilValues: map.shouldIncludeNilValues).toJSON(field) as Any? {
			setValue(result, map: map)
		}
	}
	
	class func optionalObject<N: BaseMappable>(_ field: N?, map: Map) {
		if let field = field {
			object(field, map: map)
		} else if map.shouldIncludeNilValues {
			setValue(field, map: map)
		}
	}

	class func objectArray<N: BaseMappable>(_ field: Array<N>, map: Map) {
		let JSONObjects = Mapper(context: map.context, shouldIncludeNilValues: map.shouldIncludeNilValues).toJSONArray(field)
		
		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectArray<N: BaseMappable>(_ field: Array<N>?, map: Map) {
		if let field = field {
			objectArray(field, map: map)
		}
	}
	
	class func twoDimensionalObjectArray<N: BaseMappable>(_ field: Array<Array<N>>, map: Map) {
		var array = [[[String: Any]]]()
		for innerArray in field {
			let JSONObjects = Mapper(context: map.context, shouldIncludeNilValues: map.shouldIncludeNilValues).toJSONArray(innerArray)
			array.append(JSONObjects)
		}
		setValue(array, map: map)
	}
	
	class func optionalTwoDimensionalObjectArray<N: BaseMappable>(_ field: Array<Array<N>>?, map: Map) {
		if let field = field {
			twoDimensionalObjectArray(field, map: map)
		}
	}
	
	class func objectSet<N: BaseMappable>(_ field: Set<N>, map: Map) {
		let JSONObjects = Mapper(context: map.context, shouldIncludeNilValues: map.shouldIncludeNilValues).toJSONSet(field)
		
		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectSet<N: BaseMappable>(_ field: Set<N>?, map: Map) {
		if let field = field {
			objectSet(field, map: map)
		}
	}
	
	class func objectDictionary<N: BaseMappable>(_ field: Dictionary<String, N>, map: Map) {
		let JSONObjects = Mapper(context: map.context, shouldIncludeNilValues: map.shouldIncludeNilValues).toJSONDictionary(field)
		
		setValue(JSONObjects, map: map)
	}

	class func optionalObjectDictionary<N: BaseMappable>(_ field: Dictionary<String, N>?, map: Map) {
		if let field = field {
			objectDictionary(field, map: map)
		}
	}

	class func objectDictionaryOfArrays<N: BaseMappable>(_ field: Dictionary<String, [N]>, map: Map) {
		let JSONObjects = Mapper(context: map.context, shouldIncludeNilValues: map.shouldIncludeNilValues).toJSONDictionaryOfArrays(field)

		setValue(JSONObjects, map: map)
	}
	
	class func optionalObjectDictionaryOfArrays<N: BaseMappable>(_ field: Dictionary<String, [N]>?, map: Map) {
		if let field = field {
			objectDictionaryOfArrays(field, map: map)
		}
	}
}
