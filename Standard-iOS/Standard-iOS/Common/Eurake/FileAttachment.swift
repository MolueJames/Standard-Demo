//
//  ImageAttachment.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/4/22.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import ObjectMapper

public class FileAttachment: Equatable, Mappable {
    public required init?(map: Map) {
        id <- map["id"]
        url <- map["url"]
    }
    
    public func mapping(map: Map) {
        id >>> map["id"]
    }
    
    public static func == (lhs: FileAttachment, rhs: FileAttachment) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(_ image: UIImage? = nil) {
        self.image = image
    }
    
    public func update(with item: FileAttachment?) -> FileAttachment {
        do {
            let result = try item.unwrap()
            self.url = result.url
            self.id  = result.id
        } catch {
            Logger.network.message(error)
        }
        return self
    }
    
    var image: UIImage?
    
    var url: String?
    
    var id: Int?
}
