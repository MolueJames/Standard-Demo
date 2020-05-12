//
//  UINavigationControllerExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/6/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Methods
public extension UINavigationController {
	
	/// SwifterSwift: Pop ViewController with completion handler.
	///
	/// - Parameter completion: optional completion handler (default is nil).
	func popViewController(_ completion: (() -> Void)? = nil) {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		popViewController(animated: true)
		CATransaction.commit()
	}
	
	/// SwifterSwift: Push ViewController with completion handler.
	///
	/// - Parameters:
	///   - viewController: viewController to push.
	///   - completion: optional completion handler (default is nil).
	func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
		// https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
		CATransaction.begin()
		CATransaction.setCompletionBlock(completion)
		pushViewController(viewController, animated: true)
		CATransaction.commit()
	}
	
	/// SwifterSwift: Make navigation controller's navigation bar transparent.
	///
	/// - Parameter tint: tint color (default is .white).
	func makeTransparent(withTint tint: UIColor = .white) {
		navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationBar.shadowImage = UIImage()
		navigationBar.isTranslucent = true
		navigationBar.tintColor = tint
		navigationBar.titleTextAttributes = [.foregroundColor: tint]
	}
	
}

extension UINavigationController {
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let visibleViewController = visibleViewController {
            return visibleViewController.preferredInterfaceOrientationForPresentation
        } else {
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let visibleViewController = visibleViewController {
            return visibleViewController.supportedInterfaceOrientations
        } else {
            return super.supportedInterfaceOrientations
        }
    }
    
    override open var shouldAutorotate: Bool {
        if let visibleViewController = visibleViewController {
            return visibleViewController.shouldAutorotate
        } else {
            return super.shouldAutorotate
        }
    }
}

extension UITabBarController {
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let selectedViewController = selectedViewController {
            return selectedViewController.preferredInterfaceOrientationForPresentation
        } else {
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let selectedViewController = selectedViewController {
            return selectedViewController.supportedInterfaceOrientations
        } else {
            return super.supportedInterfaceOrientations
        }
    }
    
    open override var shouldAutorotate: Bool {
        if let selected = selectedViewController {
            return selected.shouldAutorotate
        } else {
            return super.shouldAutorotate
        }
    }
}
#endif
