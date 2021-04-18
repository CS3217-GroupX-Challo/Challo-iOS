//
//  GuideDashboardRouter.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI

class GuideDashboardRouter: RouterProtocol {

    weak var presenter: GuideDashboardPresenter! {
        didSet {
            initSubmodules()
        }
    }

    var earningsHistoryPage: AnyView!
    var upcomingBookingsPage: AnyView!

    private func initSubmodules() {
        let userState = presenter.userState
        let bookingRepository = presenter.bookingRepository
        let sendMessageToTourist = presenter.sendMessageToTourist
        earningsHistoryPage = GuideEarningsModule(userState: userState,
                                                  bookingRepository: bookingRepository,
                                                  sendMessageToTourist: sendMessageToTourist).assemble().view
        upcomingBookingsPage = GuideUpcomingBookingsModule(userState: userState,
                                                           bookingRepository: bookingRepository,
                                                           sendMessageToTourist: sendMessageToTourist).assemble().view
    }
}
