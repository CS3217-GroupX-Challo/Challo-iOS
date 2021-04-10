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
    @Binding var excludedDates: Set<Date>
    @Binding var selectedDate: Date?

    @State private var selectedDay: Day?
    
    func makeUIView(context: Context) -> CalendarView {
        let calendarView = CalendarView(initialContent: makeInitialContent())
        calendarView.daySelectionHandler = { day in
            guard let date = Calendar.current.date(from: day.components),
                  !shouldBeDisabled(day: day) else {
                return
            }
            selectedDay = day
            selectedDate = date
        }
        return calendarView
    }

    func updateUIView(_ uiView: CalendarView, context: UIViewRepresentableContext<HorizonCalendarView>) {
        uiView.setContent(makeContent())
    }

    private func makeInitialContent() -> CalendarViewContent {
        let calendar = Calendar.current
        return CalendarViewContent(
          calendar: calendar,
          visibleDateRange: dateRange,
          monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))

        .withInterMonthSpacing(24)
        .withVerticalDayMargin(8)
        .withHorizontalDayMargin(8)
            
        .withDayItemModelProvider { day in
            let textColor = UIColor(Color.themeSecondary)
            return CalendarItemModel<DayView>(
                      invariantViewProperties: .init(textColor: textColor,
                                                     isDisabledStyle: true,
                                                     isSelectedStyle: false),
                      viewModel: .init(dayText: "\(day.day)"))
        }
    }

    private func makeContent() -> CalendarViewContent {
        let calendar = Calendar.current
        return CalendarViewContent(
          calendar: calendar,
          visibleDateRange: dateRange,
          monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))

        .withInterMonthSpacing(24)
        .withVerticalDayMargin(8)
        .withHorizontalDayMargin(8)
            
        .withDayItemModelProvider { day in
            let textColor = UIColor(Color.themeSecondary)
            return CalendarItemModel<DayView>(
                      invariantViewProperties: .init(textColor: textColor,
                                                     isDisabledStyle: shouldBeDisabled(day: day),
                                                     isSelectedStyle: day == selectedDay),
                      viewModel: .init(dayText: "\(day.day)"))
        }
    }

    private func shouldBeDisabled(day: Day) -> Bool {
        guard let date = Calendar.current.date(from: day.components) else {
            return true
        }
        return !dateRange.contains(date) || excludedDates.contains(date)
    }
}
