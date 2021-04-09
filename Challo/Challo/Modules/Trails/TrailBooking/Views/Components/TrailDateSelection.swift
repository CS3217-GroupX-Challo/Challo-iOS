//
//  TrailDateSelection.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailDateSelection: View {

    @Binding var selectedDate: Date
    var dateRange: ClosedRange<Date>

    var body: some View {
        HorizonCalendarView(dateRange: dateRange) { date in
            selectedDate = date
        }
    }
}
