//
//  FoundationDeprecated.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 11/8/17.
//  Copyright © 2017 SwifterSwift
//

import Foundation

// MARK: - Properties
public extension Date {
	
	/// SwifterSwift: Check if date is within the current week.
	@available(*, deprecated, message: "Use isInCurrentWeek instead", renamed: "isInCurrentWeek")
    var isInThisWeek: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
	}
	
	/// SwifterSwift: Check if date is within the current month.
	@available(*, deprecated, message: "Use isInCurrentMonth instead", renamed: "isInCurrentMonth")
    var isInThisMonth: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
	}
	
	/// SwifterSwift: Check if date is within the current year.
	@available(*, deprecated, message: "Use isInCurrentYear instead", renamed: "isInCurrentYear")
    var isInThisYear: Bool {
		return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
	}
	
}
