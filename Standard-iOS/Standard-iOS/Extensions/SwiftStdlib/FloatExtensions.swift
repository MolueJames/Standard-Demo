//
//  FloatExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/8/16.
//  Copyright © 2016 SwifterSwift
//

import CoreGraphics

// MARK: - Properties
public extension Float {
	
	/// SwifterSwift: Int.
	var int: Int {
		return Int(self)
	}
	
	/// SwifterSwift: Double.
	var double: Double {
		return Double(self)
	}
	
	/// SwifterSwift: CGFloat.
	var cgFloat: CGFloat {
		return CGFloat(self)
	}
	
}

// MARK: - Operators

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
/// SwifterSwift: Value of exponentiation.
///
/// - Parameters:
///   - lhs: base float.
///   - rhs: exponent float.
/// - Returns: exponentiation result (4.4 ** 0.5 = 2.0976176963).
func ** (lhs: Float, rhs: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return pow(lhs, rhs)
}

prefix operator √
/// SwifterSwift: Square root of float.
///
/// - Parameter float: float value to find square root for
/// - Returns: square root of given float.
public prefix func √ (float: Float) -> Float {
	// http://nshipster.com/swift-operators/
	return sqrt(float)
}
