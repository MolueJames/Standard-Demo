//
//  YunZhouCommonColor.swift
//  YunZhouCommon
//
//  Created by James on 2018/4/28.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import UIKit

public struct CommonColor {
    public static let titleLabel = UIColor(hex: 0x333333)
    public static let commonLine = UIColor(hex: 0xCCCCCC)
    public static let detailText = UIColor(hex: 0x666666)
    public static let appDefault = UIColor(hex: 0x1B82D2)
}

public struct Format {
    public static let date = "yyyy年MM月dd日"
}

public struct AppFont {
    
    public static let title = UIFont.systemFont(ofSize: 16)
    
    public static let text = UIFont.systemFont(ofSize: 15)
}

public struct DefaultBuilder {
    
    static let itemSize: CGSize = {
        if AppConfigure.isPad && SceneManager.shared.isLandscape {
            let width: CGFloat = (AppConfigure.ScreenWidth - 80) / 4 - 1
            return CGSize(width: width, height: 210)
        }
        if AppConfigure.isPad && SceneManager.shared.isPortrait {
            let width: CGFloat = (AppConfigure.ScreenWidth - 60) / 3 - 1
            return CGSize(width: width, height: 210)
        }
        let width: CGFloat = (AppConfigure.ScreenWidth - 30) / 2 - 1
        return CGSize(width: width, height: 130)
    }()
    
    static let insert: UIEdgeInsets = {
        if AppConfigure.isPad {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else {
            return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        }
    }()
    
    static func flowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let spacing: CGFloat = AppConfigure.isPad ? 20 : 10
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }
}
