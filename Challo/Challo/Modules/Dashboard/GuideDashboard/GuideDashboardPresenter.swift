//
//  GuideDashboardPresenter.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideDashboardPresenter: PresenterProtocol {

    var router: GuideDashboardRouter?
    var interactor: GuideDashboardInteractor! {
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

    init(userState: UserStateProtocol) {
        self.userState = userState
        self.name = userState.name
    }

}
