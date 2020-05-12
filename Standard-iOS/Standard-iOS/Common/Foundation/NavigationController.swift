//
//  NavigationController.swift
//  YunZhouFoundation
//
//  Created by James on 2018/4/17.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import UIKit

open class NavigationController: UINavigationController, UINavigationBarDelegate {

    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    open override var childForStatusBarStyle: UIViewController? {
        get {
            return self.topViewController
        }
    }

    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        do {
            let topViewController: UIViewController = try self.topViewController.unwrap()
            let controller: NavigationBarItemProtocol = try viewController.toTarget()
            let backButtonItem: UIBarButtonItem = controller.customBackBarButtonItem
            topViewController.navigationItem.backBarButtonItem = backButtonItem
        } catch {
            Logger.surface.message(error)
        }
        super.pushViewController(viewController, animated: animated)
    }
}

public protocol NavigateViewProtocol where Self: UIViewController{
    
    var navigationView: UIView { get set }
    
    var height: CGFloat { get set }
    
    func hideNavigationView(animated: Bool)
    
    func showNavigationView(animated: Bool)
    
    func updateNavigationView(height: CGFloat)
    
    func updateNavigationView(color: UIColor)
    
    func updateNavigationView()
}

extension NavigateViewProtocol {
    public func updateNavigationView() {
        do {
            let parent: UIViewController = try self.parent.unwrap()
            let _: UINavigationController = try parent.toTarget()
            self.view.addSubview(self.navigationView)
            self.navigationView.snp.updateConstraints { [unowned self] (make) in
                make.height.equalTo(self.height)
            }
            self.navigationView.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
            }
        } catch {
            Logger.surface.message(error)
        }
    }
    
    public func hideNavigationView(animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.updateNavigationView(height: 0)
        self.navigationViewAnimate(animated)
    }
    
    public func showNavigationView(animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.updateNavigationView(height: self.height)
        self.navigationViewAnimate(animated)
    }
    
    private func navigationViewAnimate(_ animated: Bool) {
        guard animated == true else { return }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    public func updateNavigationView(color: UIColor) {
        self.navigationView.backgroundColor = color
    }
    
    public func updateNavigationView(height: CGFloat) {
        self.navigationView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
}
