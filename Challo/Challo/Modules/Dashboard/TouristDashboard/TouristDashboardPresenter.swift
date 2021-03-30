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

    @Published var isLoading = false
    
    @Published var bookings: [Booking] = []
    
    func populateBookings() {
        isLoading = true
        interactor.populateBookings()
    }

    func didPopulateBookings(bookings: [Booking]) {
        self.bookings = bookings
        isLoading = false
    }
}
