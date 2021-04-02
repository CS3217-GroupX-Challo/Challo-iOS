//
//  EarningSubPresenter.swift
//  Challo
//
//  Created by Ying Gao on 3/4/21.
//

import Foundation

protocol EarningSubPresenter: AnyObject {

    var interactor: GuideDashboardInteractor! { get set }

    func refresh()

    func didPopulateBookings(bookings: [Booking])

}

extension EarningSubPresenter {

    func refresh() {
        interactor.populateBookings(callback: didPopulateBookings(bookings:))
    }
    
}
