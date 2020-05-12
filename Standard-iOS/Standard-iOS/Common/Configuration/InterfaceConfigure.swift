//
//  InterfaceConfigure.swift
//  YunZhouCommon
//
//  Created by James on 2018/5/7.
//  Copyright ©2018年 YunZhou. All rights reserved.
//
import Foundation
import AppSwizzle
import ObjectMapper
import Eureka
import UIKit

public class InterfaceConfigure {
    private static func navigationBarAppearance() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white]
        let height: CGFloat = ScreenKit.navHeight()
        let color: UIColor = CommonColor.appDefault
        let size = CGSize(width: AppConfigure.ScreenWidth, height: height)
        let backgroundImage = UIImage(color: color, size: size)
        navigationBar.setBackgroundImage(backgroundImage, for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = .white
    }
    
    private static func barButtonItemAppearance() {
        let item = UIBarButtonItem.appearance(whenContainedInInstancesOf:[UINavigationBar.self])
        let itemAttributesDic = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white]
        item.setTitleTextAttributes(itemAttributesDic, for: .normal)
    }
    
    private static func setViewsAppearanceConfigure() {
        UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
    }
    
    private static func updateUITabBarAppearance() {
        let tabBar = UITabBar.appearance(whenContainedInInstancesOf: [UITabBarController.self])
        let size = CGSize(width: AppConfigure.ScreenWidth, height: 49)
        tabBar.backgroundImage = UIImage(color: .white, size: size)
        tabBar.tintColor = UIColor(hex: 0x1B82D2)
    }
    
    public static func defaultConfigure() {
        DispatchQueue.once {
            self.setViewsAppearanceConfigure()
            self.updateUITabBarAppearance()
            self.barButtonItemAppearance()
            self.navigationBarAppearance()
            EurakeConfigure.setDefault()
        }
    }
}

