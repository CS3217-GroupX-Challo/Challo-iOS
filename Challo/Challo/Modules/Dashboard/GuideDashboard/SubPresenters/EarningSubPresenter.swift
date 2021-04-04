//
//  EarningSubPresenter.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import Foundation

protocol EarningSubPresenter: ObservableObject {

    var interactor: GuideDashboardInteractor! { get set }

    var loading: Bool { get }

    var dateRange: [Date] { get }

    var history: [Double] { get }

    var totalEarnings: Double { get }

    func refresh()

    func didPopulateBookings(bookings: [Booking])

}

extension EarningSubPresenter {

    func refresh() {
        interactor.populateBookings(callback: didPopulateBookings(bookings:))
    }
    
}
