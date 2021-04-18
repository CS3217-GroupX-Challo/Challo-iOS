//
//  GuideDashboardRouter.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI

class GuideDashboardRouter: RouterProtocol {

    weak var presenter: GuideDashboardPresenter!
    let userState: UserStateProtocol
    let guideAPI: GuideAPIProtocol
    let trailRepository: TrailRepositoryProtocol
    let bookingRepository: BookingRepositoryProtocol
    let sendMessageToTourist: (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void

    init(userState: UserStateProtocol,
         guideAPI: GuideAPIProtocol,
         bookingRepository: BookingRepositoryProtocol,
         trailRepository: TrailRepositoryProtocol,
         sendMessageToTourist: @escaping (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void) {
        self.userState = userState
        self.guideAPI = guideAPI
        self.trailRepository = trailRepository
        self.bookingRepository = bookingRepository
        self.sendMessageToTourist = sendMessageToTourist
        self.initSubmodules()
    }

    func getOnboardingPage() -> AnyView {
        let onboardingModule = GuideOnboardingModule(userState: userState,
                                                     trailRepository: trailRepository,
                                                     guideAPI: guideAPI)
        return onboardingModule.assemble().view
    }

    var earningsHistoryPage: AnyView!
    var upcomingBookingsPage: AnyView!

    private func initSubmodules() {
        earningsHistoryPage = GuideEarningsModule(userState: userState,
                                                  bookingRepository: bookingRepository,
                                                  sendMessageToTourist: sendMessageToTourist).assemble().view
        upcomingBookingsPage = GuideUpcomingBookingsModule(userState: userState,
                                                           bookingRepository: bookingRepository,
                                                           sendMessageToTourist: sendMessageToTourist).assemble().view
    }
}
