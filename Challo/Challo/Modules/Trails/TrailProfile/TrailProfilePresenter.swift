//
//  TrailProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfilePresenter: PresenterProtocol, ObservableObject {

    var interactor: TrailProfileInteractor!
    var router: TrailProfileRouter?
    var trailBookingPage: AnyView? {
        router?.trailBookingPage
    }

    @Published var isLoadingReviews = false
    var reviews: [Review] = []
    var currentTrail: Trail?
    
    func didGetReviewsForTrail(reviews: [Review]) {
        self.reviews = reviews
        isLoadingReviews = false
    }
    
    func populateTrailProfilePageFor(trail: Trail) {
        currentTrail = trail
        isLoadingReviews = true
        interactor.getReviewsForTrail(trailId: trail.trailId, callback: didGetReviewsForTrail)
    }
    
    func onTapBookTrailButton() -> some View {
        router?.trailBookingPage
    }
}
