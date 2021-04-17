//
//  GuideEarningsPresenter.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideEarningsPresenter: PresenterProtocol, ProfileImageProvider {

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

}
