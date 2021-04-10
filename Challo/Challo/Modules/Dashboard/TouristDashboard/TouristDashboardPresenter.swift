//
//  DashboardPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

class TouristDashboardPresenter: PresenterProtocol {
    
    var router: TouristDashboardRouter?
    var interactor: TouristDashboardInteractor!
    unowned let userState: UserStateProtocol!

    let sendMessageToGuide: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)
    
    @Published var isLoading = false
    
    @Published var upcomingBookings: [Booking] = []

    @Published var pastBookings: [Booking] = []
    
    @Published var name: String
    
    @Published var messageText: String = ""

    private static let tabs = TouristDashboardTabs.allCases
    let tabTitles = tabs.map { $0.rawValue }
    @Published var selectedIdx = 0 {
        didSet {
            selectedTab = Self.tabs[selectedIdx]
        }
    }
    @Published var selectedTab: TouristDashboardTabs = tabs[0]
    
    init(userState: UserStateProtocol,
         sendMessageToGuide: @escaping ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.name = userState.name
        self.sendMessageToGuide = sendMessageToGuide
    }

    func refresh() {
        self.name = userState.name
        populateBookings()
    }
    
    func populateBookings() {
        isLoading = true
        interactor.populateBookings()
    }

    func didPopulateBookings(bookings: [Booking]) {
        self.upcomingBookings = filterUpcomingBookings(bookings: bookings)
        self.pastBookings = filterPastBookings(bookings: bookings)
        isLoading = false
    }

    private func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            ($0.status == .Paid || $0.status == .Pending) && $0.date > Date()
        }
    }

    private func filterPastBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.date < Date()
        }
    }
    
    func onTapSendMessage(guide: Guide) {
        sendMessageToGuide(guide.email, guide.userId, messageText)
        messageText = ""
    }
}

enum TouristDashboardTabs: String, CaseIterable {
    case upcomingBookings = "Upcoming Bookings"
    case pastBookings = "Past Bookings"
}
