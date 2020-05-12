//
//  PhotoService.swift
//  Standard-iOS
//
//  Created by James on 2019/11/20.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import UIKit

public struct PictureService {
    
    public static func uploadPhoto(with fileData: Data) -> AppUploadRequest {
        let urlPath: String = HTTPConfigure.baseURL + "/certi_auth/fileResource"
        return AppUploadRequest(urlPath: urlPath, formBody: FormBody(fileData))
    }
}
