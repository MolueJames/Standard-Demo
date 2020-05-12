//
//  UINavigationControllerType.swift
//  YunZhouMediator
//
//  Created by James on 2018/10/2.
//  Copyright © 2018 James. All rights reserved.
//

import Foundation
import UIKit

public protocol UINavigationControllerType {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
}

public protocol UIViewControllerType {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

extension UINavigationController: UINavigationControllerType{}
extension UIViewController: UIViewControllerType{}
