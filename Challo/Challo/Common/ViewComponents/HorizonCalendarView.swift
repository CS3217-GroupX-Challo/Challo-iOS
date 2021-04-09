//
//  HorizonView.swift
//  Challo
//
//  Created by Tan Le Yang on 9/4/21.
//

import SwiftUI
import HorizonCalendar

struct HorizonCalendarView: UIViewRepresentable {

    var dateRange: ClosedRange<Date>
    var dateSelectionHandler: (Date) -> Void
    
    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeContent())
        calendarView.daySelectionHandler = { day in
            guard let date = Calendar.current.date(from: day.components) else {
                return
            }
            dateSelectionHandler(date)
        }
        return calendarView
    }

    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<HorizonCalendarView>) {}

    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar(identifier: .gregorian)
        return CalendarViewContent(
          calendar: calendar,
          visibleDateRange: dateRange,
          monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }
}
