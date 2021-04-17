//
//  DashboardRouter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

class TouristDashboardRouter: RouterProtocol {

    weak var presenter: TouristDashboardPresenter!
    private let reviewAPI: ReviewAPIProtocol
    
    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }

    func getReviewPage(for booking: Booking) -> AnyView {
        let reviewModule = ReviewModule(reviewAPI: reviewAPI, booking: booking)
        return reviewModule.assemble().view
    }
}
