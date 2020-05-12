//
//  SceneManager.swift
//  Standard-iOS
//
//  Created by James on 2019/9/22.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import UIKit

public protocol WindowScenceProtocol {
    var isLandscape: Bool { get }
    
    var isPortrait: Bool { get }
    
    var orientationStatus: UIInterfaceOrientation { get }
    
    var statusBarManager: UIStatusBarManager? { get }
    
    var statusBarFrame: CGRect { get }
    
    var statusBarHeight: CGFloat { get }
    
    var isStatusBarHidden: Bool { get }
}

fileprivate let single = SceneManager()

public class SceneManager: WindowScenceProtocol {
    public var isLandscape: Bool {
        return self.orientationStatus.isLandscape
    }
    
    public var isPortrait: Bool {
        return self.orientationStatus.isPortrait
    }
    
    public var orientationStatus: UIInterfaceOrientation {
        return self.scene.interfaceOrientation
    }
    
    public var statusBarManager: UIStatusBarManager? {
        return self.scene.statusBarManager
    }
    
    public var statusBarFrame: CGRect {
        return self.statusBarManager?.statusBarFrame ?? CGRect.zero
    }
    
    public var statusBarHeight: CGFloat {
        return self.statusBarFrame.height
    }
    
    public var isStatusBarHidden: Bool {
        return self.statusBarManager?.isStatusBarHidden ?? false
    }
    
    public static var shared : SceneManager {
        return single
    }
    
    public weak var scene: UIWindowScene!
    
    public weak var window: UIWindow?
}
