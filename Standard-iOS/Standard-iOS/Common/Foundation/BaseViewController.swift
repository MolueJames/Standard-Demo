//
//  BaseViewController.swift
//  YunZhouFoundation
//
//  Created by James on 2018/4/17.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import UIKit
import SnapKit

open class BaseViewController: UIViewController, NavigationBarItemProtocol, NetworkLoadingProtocol {
    
    private var networkcount = 0 {
        didSet {
            self.needToDo(newValue: networkcount, oldValue: oldValue)
        }
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        get { return .lightContent }
    }
    
    open override var prefersStatusBarHidden: Bool {
        get { return false }
    }
    
    open override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        get { return .slide }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.updateControllerElements()
        self.performInterfaceProtocol()
    }
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let controller: OrientiationProtocol = try? self.toTarget() {
            controller.flowLayout.itemSize = controller.itemSize
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    private func performInterfaceProtocol() {
        do {
            let controller: UserInterfaceProtocol = try self.toTarget()
            controller.queryInformationWithNetwork()
            controller.updateUserInterfaceElements()
        } catch {
            Logger.surface.message(error)
        }
    }
    private func updateControllerElements() {
        self.view.backgroundColor = UIColor(hex: 0xf5f5f9)
        self.edgesForExtendedLayout = .all
    }
    
    deinit {
        Logger.dealloc.message(String(describing: self))
    }
}

extension BaseViewController : ActivityDelegate {
    public func networkActivityStarted() {
        self.networkcount = self.networkcount + 1
    }
    
    public func networkActivitySuccess() {
        self.networkcount = self.networkcount - 1
    }
    
    public func networkActivityFailure(error: Error) {
        self.networkcount = self.networkcount - 1
        let message = error.localizedDescription
        self.showFailureHUD(text: message)
    }
}
