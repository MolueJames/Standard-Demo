//
//  BaseFormController.swift
//  Standard-iOS
//
//  Created by James on 2019/3/7.
//  Copyright © 2019 YunZhou. All rights reserved.
//

import UIKit
import Eureka

class BaseFormController: FormViewController, NavigationBarItemProtocol, NetworkLoadingProtocol {
    
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

extension BaseFormController : ActivityDelegate {
    public func networkActivityStarted() {
        self.networkcount = self.networkcount + 1
    }
    public func networkActivitySuccess() {
        self.networkcount = self.networkcount - 1
    }
    public func networkActivityFailure(error: Error) {
        self.networkcount = self.networkcount - 1
        self.showFailureHUD(text: error.localizedDescription)
    }
}
