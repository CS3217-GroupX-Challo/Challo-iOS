//
//  CustomDateFormatter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import Foundation

struct CustomDateFormatter {
    private static let formatter = DateFormatter()
    
    private static let monthYearFormatter = DateFormatter.dateFormat(fromTemplate: "MMM yyyy",
                                                                     options: 0, locale: Locale(identifier: "en-SG"))
    
    static func displayDateAsMonthYear(_ date: Date) -> String {
        formatter.dateFormat = monthYearFormatter
        return formatter.string(from: date)
    }
    
    private static let dayFormatter = DateFormatter.dateFormat(fromTemplate: "E",
                                                               options: 0, locale: Locale(identifier: "en-SG"))
    
    static func displayDateAsDay(_ date: Date) -> String {
        formatter.dateFormat = dayFormatter
        return formatter.string(from: date)
    }
    
    private static let timeFormatter = DateFormatter.dateFormat(fromTemplate: "hh:mm",
                                                                options: 0, locale: Locale(identifier: "en-SG"))
    
    static func displayDateAsTime(_ date: Date) -> String {
        formatter.dateFormat = timeFormatter
        return formatter.string(from: date)
    }
    
    private static let dateFormatter = DateFormatter.dateFormat(fromTemplate: "dd-MM-yyyy",
                                                                options: 0, locale: Locale(identifier: "en-SG"))
    
    static func displayFriendlyDate(_ date: Date) -> String {
        formatter.dateFormat = dateFormatter
        return formatter.string(from: date)
    }
    
    private static let datetimeFormatter = DateFormatter.dateFormat(fromTemplate: "dd-MM-yyyy, hh:mm",
                                                                    options: 0, locale: Locale(identifier: "en-SG"))
    
    static func displayFriendlyDateTime(_ date: Date) -> String {
        formatter.dateFormat = datetimeFormatter
        return formatter.string(from: date)
    }

    /// Formats a given date into the given template. Template follows the standard date formatting syntax (go Google).
    static func displayDateWithCustomFormat(_ date: Date, template: String) -> String {
        formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: template,
                                                        options: 0, locale: Locale(identifier: "en-SG"))
        return formatter.string(from: date)
    }

}
