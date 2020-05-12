//
//  OptionalExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 3/3/17.
//  Copyright © 2017 SwifterSwift
//
import Foundation

// MARK: - Methods
public extension Optional {
	
	/// SwifterSwift: Get self of default value (if self is nil).
	///
	///		let foo: String? = nil
	///		print(foo.unwrapped(or: "bar")) -> "bar"
	///
	///		let bar: String? = "bar"
	///		print(bar.unwrapped(or: "foo")) -> "bar"
	///
	/// - Parameter defaultValue: default value to return if self is nil.
	/// - Returns: self if not nil or default value if nil.
	func unwrapped(or defaultValue: Wrapped) -> Wrapped {
		// http://www.russbishop.net/improving-optionals
		return self ?? defaultValue
	}
	
    /// SwifterSwift: Gets the wrapped value of an optional. If the optional is `nil`, throw a custom error.
    ///
    ///        let foo: String? = nil
    ///        try print(foo.unwrapped(or: MyError.notFound)) -> error: MyError.notFound
    ///
    ///        let bar: String? = "bar"
    ///        try print(bar.unwrapped(or: MyError.notFound)) -> "bar"
    ///
    /// - Parameter error: The error to throw if the optional is `nil`.
    /// - Returns: The value wrapped by the optional.
    /// - Throws: The error passed in.
    func unwrapped(or error: Error) throws -> Wrapped {
        guard let wrapped = self else {
            throw error
        }
        return wrapped
    }
    
	/// SwifterSwift: Runs a block to Wrapped if not nil
	///
	///		let foo: String? = nil
	///		foo.run { unwrappedFoo in
	///			// block will never run sice foo is nill
	///			print(unwrappedFoo)
	///		}
	///
	///		let bar: String? = "bar"
	///		bar.run { unwrappedBar in
	///			// block will run sice bar is not nill
	///			print(unwrappedBar) -> "bar"
	///		}
	///
	/// - Parameter block: a block to run if self is not nil.
	func run(_ block: (Wrapped) -> Void) {
		// http://www.russbishop.net/improving-optionals
		_ = self.map(block)
	}
	
	/// SwifterSwift: Assign an optional value to a variable only if the value is not nil.
	///
	///     let someParameter: String? = nil
	///     let parameters = [String:Any]() //Some parameters to be attached to a GET request
	///     parameters[someKey] ??= someParameter //It won't be added to the parameters dict
	///
	/// - Parameters:
	///   - lhs: Any?
	///   - rhs: Any?
	static func ??= (lhs: inout Optional, rhs: Optional) {
		guard let rhs = rhs else { return }
		lhs = rhs
	}
    
    func isNone() -> Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
    
    /// 可选值非空返回 true
    func isSome() -> Bool {
        return !isNone()
    }
}

public extension Optional {
    @discardableResult
    func unwrap(file: String = #file, function: String = #function, line: Int = #line) throws -> Wrapped {
        if let unwrapped = self { return unwrapped }
        throw AppError(file: file, function: function, line: line)
    }
}

public extension Optional where Wrapped == String {
    func value() -> String {
        do { return try self.unwrap()
        } catch { return "暂无数据" }
    }
    
    func isEmpty() -> Bool {
        do { return try self.unwrap().isEmpty
        } catch { return true }
    }
}

// MARK: - Operators
infix operator ??= : AssignmentPrecedence
