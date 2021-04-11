//
//  GuideDashboardSubPresenter.swift
//  Challo
//
//  Created by Ying Gao on 4/4/21.
//

import SwiftUI

protocol GuideDashboardSubPresenter: ObservableObject {

    var interactor: GuideEarningsInteractor! { get set }

    var loading: Bool { get }

    func refresh()

    func didPopulateBookings(bookings: [Booking])

}

extension GuideDashboardSubPresenter {

    func refresh() {
        interactor.populateBookings(callback: didPopulateBookings(bookings:))
    }

}
