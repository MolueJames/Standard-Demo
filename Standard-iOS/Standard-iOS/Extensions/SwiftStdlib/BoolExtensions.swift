//
//  BoolExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 07/12/2016.
//  Copyright © 2016 SwifterSwift
//
import Foundation

// MARK: - Properties
public extension Bool {
	
	/// SwifterSwift: Return 1 if true, or 0 if false.
	///
	///		false.int -> 0
	///		true.int -> 1
	///
	var int: Int {
		return self ? 1 : 0
	}
	
	/// SwifterSwift: Return "true" if true, or "false" if false.
	///
	///		false.string -> "false"
	///		true.string -> "true"
	///
	var string: String {
		return description
	}
	
	/// SwifterSwift: Return inversed value of bool.
	///
	///		false.toggled -> true
	///		true.toggled -> false
	///
	var toggled: Bool {
		return !self
	}
	
	/// SwifterSwift: Returns a random boolean value.
	///
	///     Bool.random -> true
	///     Bool.random -> false
	///
	static var random: Bool {
		return arc4random_uniform(2) == 1
	}
	
}

// MARK: - Methods
public extension Bool {
	
	/// SwifterSwift: Toggle value for bool.
	///
	///		var bool = false
	///		bool.toggle()
	///		print(bool) -> true
	///
	/// - Returns: inversed value of bool.
	@discardableResult mutating func toggle() -> Bool {
		self = !self
		return self
	}
	
}