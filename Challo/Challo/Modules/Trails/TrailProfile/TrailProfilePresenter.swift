//
//  TrailProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfilePresenter: EntityProfilePresenter, ObservableObject {

    var userState: UserStateProtocol
    var interactor: TrailProfileInteractor!
    var router: TrailProfileRouter?
    var trailBookingPage: AnyView? {
        router?.trailBookingPage
    }

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    @Published var isLoadingReviews = false
    @Published var isShowingNotLoggedInAlert = false
    var userCanMakeBooking: Bool {
        userState.loggedIn
    }

    var reviews: [Review] = []
    var currentEntity: Trail?
    
    func didGetReviewsForTrail(reviews: [Review]) {
        self.reviews = reviews
        isLoadingReviews = false
    }
    
    func populateProfilePage(_ entity: Trail) {
        currentEntity = entity
        isLoadingReviews = true
        interactor.getReviewsForTrail(trailId: entity.trailId, callback: didGetReviewsForTrail)
    }
}
