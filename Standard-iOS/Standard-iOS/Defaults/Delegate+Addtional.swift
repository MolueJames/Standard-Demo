//
//  Delegate+Addtional.swift
//  Standard-iOS
//
//  Created by JamesCheng on 2019-03-07.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift
import Kingfisher
import LeakEye
import Bugly

extension AppDelegate {
    public func setupAddtionalConfigure() {
        InterfaceConfigure.defaultConfigure()
        self.setupWebImageConfigure()
        self.setupIQKeyBoardManager()
        self.setupBuglyConfigure()
    }
    
    private func setupIQKeyBoardManager() {
        IQKeyboardManager.shared.enable = true
    }
    
    private func setupWebImageConfigure() {
        let cache = KingfisherManager.shared.cache
        // 设置硬盘最大保存3天 ， 默认1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 3
        // 设置硬盘最大缓存50M ，默认无限
        cache.maxDiskCacheSize = 50 * 1024 * 1024
    }
    
    private func setupBuglyConfigure() {
        let configuration = BuglyConfig.init()
        let isDebug = AppSchemeStatus.base() == .debug
        configuration.blockMonitorEnable = isDebug
        configuration.unexpectedTerminatingDetectionEnable = true
        configuration.reportLogLevel = .warn
        Bugly.start(withAppId: "38fe127d59", config: configuration)
    }

}

extension AppDelegate: LeakEyeDelegate {
    func setupLeakEyeConfigure() {
        self.leakEye.delegate = self
        self.leakEye.open()
    }
    
    func leakEye(_ leakEye:LeakEye ,didCatchLeak object: NSObject) {
        let message = "\(object) has not dealloc, please check code!"
        Logger.warning.message(MError(message: message))
    }
}

extension SceneDelegate {
    public func setupDefaultController() {
        self.setAppWindowConfiguration()
        self.setUserLoginNotification()
        self.setNeedLoginNotification()
    }
    
    private func setUserLoginNotification() {
        let name = UserNotification.user_login.toName()
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main) { [unowned self] (_) in
            self.window?.rootViewController = self.rootViewController()
            self.window?.makeKeyAndVisible()
        }
    }
    
    private func setNeedLoginNotification() {
        let name = UserNotification.need_login.toName()
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: OperationQueue.main) { [unowned self] (_) in
            self.window?.rootViewController = self.loginViewController()
            self.window?.makeKeyAndVisible()
            DatabaseLogic.disconnect()
        }
    }
    
    public func setAppWindowConfiguration() {
        do {
            let window = try self.window.unwrap()
            self.setRootViewController(for: window)
        } catch {
            Logger.surface.error(error)
        }
    }
    
    private func setRootViewController(for window: UIWindow) {
        if DatabaseLogic.connectToLastDatabase() {
            window.rootViewController = self.rootViewController()
        } else {
            window.rootViewController = self.loginViewController()
        }
        window.makeKeyAndVisible()
    }
    
    private func loginViewController() -> UIViewController? {
        let loginController = UIViewController()
        return NavigationController(rootViewController: loginController)
    }
    
    private func rootViewController() -> UIViewController {
        var viewControllers = [NavigationController]()
        self.addEnterpriseListController(&viewControllers)
        self.addUserCenterViewController(&viewControllers)
        let tabbarController = TabBarController()
        tabbarController.viewControllers = viewControllers
        return tabbarController
    }
    
    private func addEnterpriseListController(_ controllers: inout [NavigationController]) {
        let controller = UIViewController()
        controller.tabBarItem = UITabBarItem(title: "目标企业", image: UIImage(named: "tabbar_enterprise"), tag: controllers.count)
        controllers.append(NavigationController(rootViewController: controller))
    }
    
    private func addUserCenterViewController(_ controllers: inout [NavigationController]) {
        let controller = UIViewController()
        controller.tabBarItem = UITabBarItem(title: "用户中心", image: UIImage(named: "tabbar_usercenter"), tag: controllers.count)
        controllers.append(NavigationController(rootViewController: controller))
    }
}
