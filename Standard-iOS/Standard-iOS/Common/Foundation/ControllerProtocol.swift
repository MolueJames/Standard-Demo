//
//  NetworkLoadingProtocol.swift
//  YunZhouFoundation
//
//  Created by James on 2018/5/7.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import JGProgressHUD

public protocol UserInterfaceProtocol {
    func queryInformationWithNetwork()
    func updateUserInterfaceElements()
}

typealias NetworkLoadingProtocol = NetworkResultProtocol & LoadingIndicatorProtocol

fileprivate let hud_display_duration = 1.0

public protocol NetworkResultProtocol {
    func showSuccessHUD(text: String)
    func showFailureHUD(text: String)
    func showWarningHUD(text: String)
}

protocol LoadingIndicatorProtocol {
    func showLoadingIndicatorView()
    func hideLoadingIndicatorView()
    func needToDo(newValue: Int, oldValue: Int)
}

extension LoadingIndicatorProtocol where Self: UIViewController {
    func showLoadingIndicatorView() {
        let data = ActivityData(size: CGSize(width: 35, height: 35))
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(data, nil)
    }
    
    func hideLoadingIndicatorView() {
        NVActivityIndicatorPresenter.sharedInstance.setMessage("加载数据中...")
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    func needToDo(newValue: Int, oldValue: Int) {
        let status = self.queryStatus(newValue, oldValue)
        if status == IndicatorLoadStatus.needHide {
            self.hideLoadingIndicatorView()
        }
        if status == IndicatorLoadStatus.needShow {
            self.showLoadingIndicatorView()
        }
    }
    
    fileprivate func queryStatus(_ new: Int, _ old: Int) -> IndicatorLoadStatus {
        if new > 0 && old <= 0 { return IndicatorLoadStatus.needShow }
        if old > 0 && new <= 0 { return IndicatorLoadStatus.needHide }
        return IndicatorLoadStatus.keepLoad
    }
}

fileprivate enum IndicatorLoadStatus {
    case needShow
    case needHide
    case keepLoad
}

extension NetworkResultProtocol where Self: UIViewController {
    public func showSuccessHUD(text: String) {
        do {
            let image = try UIImage(named: "foundation_icon_success").unwrap()
            let hud = try self.createHUD(text: text, image: image).unwrap()
            self.showHUDAfterDismiss(hud)
        } catch {
            Logger.surface.error(error)
        }
    }
    public func showFailureHUD(text: String) {
        do {
            let image = try UIImage(named: "foundation_icon_failure").unwrap()
            let hud = try self.createHUD(text: text, image: image).unwrap()
            self.showHUDAfterDismiss(hud)
        } catch {
            Logger.surface.error(error)
        }
    }
    public func showWarningHUD(text: String) {
        do {
            guard text.isEmpty == false else {return}
            let hud = try self.createHUD(text: text, image: UIImage()).unwrap()
            self.showHUDAfterDismiss(hud)
        } catch {
            Logger.surface.error(error)
        }
    }
    private func createHUD(text: String, image: UIImage?) -> JGProgressHUD? {
        do {
            let ProgressHUD = JGProgressHUD(style: JGProgressHUDStyle.dark)
            let hud = try ProgressHUD.unwrap()
            hud.indicatorView = JGProgressHUDImageIndicatorView(image: image)
            hud.textLabel.text = text
            return hud
        } catch {
            return Logger.surface.returnNil(error)
        }
    }
    private func showHUDAfterDismiss(_ HUD: JGProgressHUD) {
        HUD.show(in: self.view, animated: true)
        HUD.dismiss(afterDelay: hud_display_duration, animated: true)
    }
}

protocol NavigationBarItemProtocol {
    var customBackBarButtonItem: UIBarButtonItem { get }
}

extension NavigationBarItemProtocol {
    var customBackBarButtonItem: UIBarButtonItem {
        get {
            return UIBarButtonItem(title: "返回", style: .plain, target: nil, action: nil)
        }
    }
}

public extension UIViewController {
    func handleSuccess(with notify: ToNotification) {
        NotificationCenter.default.post(name: notify.toName(), object: nil)
        self.popToPreviousController()
    }
    
    func handle(_ notify: ToNotification, item: Any?) {
        NotificationCenter.default.post(name: notify.toName(), object: item)
        self.popToPreviousController()
    }
    
    func popToPreviousController() {
        do {
            let navigationController = try self.navigationController.unwrap()
            navigationController.popViewController(animated: true)
        } catch {
            Logger.surface.message(error)
        }
    }
}

public protocol ViewableProtocol: NSObjectProtocol {
    
    func updateInterfaceElement()
    
    func insertInterfaceElement()
    
}
