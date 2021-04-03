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

}
