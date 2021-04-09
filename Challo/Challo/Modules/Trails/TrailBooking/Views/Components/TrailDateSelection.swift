//
//  TrailDateSelection.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailDateSelection: View {

    @Binding var selectedDate: Date?
    var dateRange: ClosedRange<Date>
    @Binding var excludedDates: Set<Date>

    private var dateString: String {
        guard let selectedDate = selectedDate else {
            return "Select a date to book!"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY"
        return dateFormatter.string(from: selectedDate)
    }

    var body: some View {
        VStack {
            HStack {
                Label("Selected Date: \(dateString)", systemImage: "clock")
            }
            HorizonCalendarView(dateRange: dateRange,
                                excludedDates: $excludedDates) { date in
                selectedDate = date
            }
        }
    }
}
