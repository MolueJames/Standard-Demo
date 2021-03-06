//
//  UITextViewExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 9/28/16.
//  Copyright © 2016 SwifterSwift
//

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - Methods
public extension UITextView {
	
	/// SwifterSwift: Clear text.
	func clear() {
		text = ""
		attributedText = NSAttributedString(string: "")
	}
	
	/// SwifterSwift: Scroll to the bottom of text view
	func scrollToBottom() {
		let range = NSMakeRange((text as NSString).length - 1, 1)
		scrollRangeToVisible(range)
		
	}
	
	/// SwifterSwift: Scroll to the top of text view
	func scrollToTop() {
		let range = NSMakeRange(0, 1)
		scrollRangeToVisible(range)
	}
	
}
#endif
