//
//  Date+Init.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//
import Foundation

extension Date {
    static func construct(with dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: dateString)
    }

    func destruct() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }

    func dayOfWeek() -> Days? {
        guard let dayNumber = Calendar.current.dateComponents([.weekday], from: self).weekday else {
            return nil
        }
        switch dayNumber {
        case 1:
            return .Sunday
        case 2:
            return .Monday
        case 3:
            return .Tuesday
        case 4:
            return .Wednesday
        case 5:
            return .Thursday
        case 6:
            return .Friday
        case 7:
            return .Saturday
        default:
            return nil
        }
    }

    func convertToStartOfDay() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
