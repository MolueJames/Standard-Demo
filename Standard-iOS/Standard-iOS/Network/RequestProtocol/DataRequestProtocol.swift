//
//  DataRequestProtocol.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/4/8.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import ObjectMapper

public protocol ItemQueryRequestProtocol {
    associatedtype item: Mappable
    
    var listModel: ListItem<item> { get set }
    
    func queryItemFromServer(_ item: ListItem<item>)
    
    func moreItemFromServer(_ item: ListItem<item>)
}

public protocol ItemCrudRequestProtocol {
    associatedtype item: Mappable
    
    var currentItem: item? { get set }
    
    func validateDeleteItem(with item: item?)
    
    func doUpdateItemRequest(with item: item)
    
    func doDeleteItemRequest(with item: item)
    
    func doInsertItemRequest(with item: item)
}
