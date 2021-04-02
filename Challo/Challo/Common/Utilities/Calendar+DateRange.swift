//
//  Calendar+DateRange.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import Foundation

extension Calendar {

    /// Returns all days in the current week of the day this method is called as `Date` objects.
    /// Remember to use `Calendar.isDate(_:equalTo:toGranularity: .day)`
    /// to check if a certain date matches any one day in the list.
    var daysInCurrentWeek: [Date] {
        var days = [Date]()
        guard let dateInterval = dateInterval(of: .weekOfYear, for: Date()) else {
            return days
        }
        enumerateDates(startingAfter: dateInterval.start,
                       matching: DateComponents(hour: 0),
                       matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else {
                return
            }
            if date <= dateInterval.end {
                days.append(date)
            } else {
                stop = true
            }
        }
        return days
    }

    /// Returns all months in the current year of the day this method is called as `Date` objects.
    /// Remember to use `Calendar.isDate(_:equalTo:toGranularity: .month)`
    /// to check if a certain date matches any one month in the list.
    var monthsInCurrentYear: [Date] {
        var months = [Date]()
        guard let dateInterval = dateInterval(of: .year, for: Date()) else {
            return months
        }
        enumerateDates(startingAfter: dateInterval.start,
                       matching: DateComponents(weekOfMonth: 1),
                       matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else {
                return
            }
            if date <= dateInterval.end {
                months.append(date)
            } else {
                stop = true
            }
        }
        return months
    }

}
