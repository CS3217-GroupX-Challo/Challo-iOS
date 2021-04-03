//
//  CustomDateFormatter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

struct CustomDateFormatter {
    static let formatter = DateFormatter()
    
    static let monthYearFormatter = DateFormatter.dateFormat(fromTemplate: "MMM yyyy",
                                                             options: 0, locale: Locale(identifier: "en-SG"))
    
    static func displayDateAsMonthYear(_ date: Date) -> String {
        formatter.dateFormat = monthYearFormatter
        return formatter.string(from: date)
    }

    /// Formats a given date into the given template. Template follows the standard date formatting syntax (go Google).
    static func displayDateWithCustomFormat(_ date: Date, template: String) -> String {
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template,
                                                        options: 0, locale: Locale(identifier: "en-SG"))
        return formatter.string(from: date)
    }

}
