//
//  Date+Init.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//
import Foundation

extension Date {
    static func construct(with dateString: String) -> Date? {
        let isoDate = "2016-04-14T10:44:00+0000"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: isoDate) else {
            return nil
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        let finalDate = calendar.date(from: components)
        return finalDate
    }

    func destruct() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
