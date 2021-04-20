//
//  GuideEarningsPresenter.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideEarningsPresenter: PresenterProtocol {

    var router: GuideEarningsRouter?
    var interactor: GuideEarningsInteractor! {
        didSet {
            weekSubPresenter.interactor = interactor
            yearSubPresenter.interactor = interactor
            bookingHistorySubPresenter.interactor = interactor
        }
    }

    let userState: UserStateProtocol

    @Published var name: String
    @Published var loading: Bool = true

    var weekSubPresenter = WeekEarningsPresenter()
    var yearSubPresenter = YearEarningsPresenter()
    var bookingHistorySubPresenter = GuideBookingHistorySubPresenter()

    init(userState: UserStateProtocol,
         sendMessageToTourist: @escaping ((_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.name = userState.name
        bookingHistorySubPresenter.sendMessageToUser = sendMessageToTourist
    }

    private static var tabs = EarningsDashboardTabs.allCases
    @Published var tabTitles = tabs.map { $0.rawValue }
    @Published var selectedIndex = 0 {
        didSet { selectedTab = Self.tabs[selectedIndex] }
    }
    @Published var selectedTab = tabs[0]

}

enum EarningsDashboardTabs: String, CaseIterable {
    case weeklyView = "Week View"
    case yearlyView = "Year View"
    case bookingHistory = "View Booking History"
}
