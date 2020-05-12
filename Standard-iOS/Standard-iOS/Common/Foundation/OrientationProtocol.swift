//
//  OrientiationProtocol.swift
//  Standard-iOS
//
//  Created by 程成 on 2019/6/10.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import UIKit

public protocol OrientiationProtocol {
    var flowLayout: UICollectionViewFlowLayout { get set }
    
    var itemSize: CGSize { get }
}

