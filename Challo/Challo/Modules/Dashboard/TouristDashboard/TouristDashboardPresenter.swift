//
//  DashboardPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

class TouristDashboardPresenter: PresenterProtocol, ObservableObject {
    
    var router: TouristDashboardRouter?
    var interactor: TouristDashboardInteractor!
    unowned let userState: UserStateProtocol!

    @Published var isLoading = false
    
    @Published var upcomingBookings: [Booking] = []
    
    @Published var name: String
    
    init(userState: UserStateProtocol) {
        self.userState = userState
        self.name = userState.name
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
        isLoading = false
    }

    private func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.status == .Paid || $0.status == .Pending
        }
    }
}
