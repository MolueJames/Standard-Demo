//
//  YunZhouNavigatorDelegate.swift
//  YunZhouMediator
//
//  Created by James on 2018/10/2.
//  Copyright © 2018 James. All rights reserved.
//
import Foundation
import UIKit

public protocol NavigatorDelegate: class {
    func shouldPush(viewController: UIViewController, from: UINavigationControllerType) -> Bool
    
    func shouldPresent(viewController: UIViewController, from: UIViewControllerType) -> Bool
}

extension NavigatorDelegate {
    func shouldPush(viewController: UIViewController, from: UINavigationControllerType) -> Bool {
        return true
    }
    
    func shouldPresent(viewController: UIViewController, from: UIViewControllerType) -> Bool {
        return true
    }
}
