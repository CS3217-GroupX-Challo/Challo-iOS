//
//  TrailListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingPresenter: PresenterProtocol, ObservableObject {

    var interactor: TrailListingInteractor!
    var router: TrailListingRouter?
    
    var trails: [Trail] = []
    var trailListingCards: [TrailListingCard] = []
    
    var trailProfilePage: AnyView? {
        router?.trailProfilePage
    }
    
    private func didGetAllTrails(trails: [Trail]) {
        self.trails = trails
        trailListingCards = trails.map(transformTrailToTrailListingCard)
    }
    
    func getAllTrails() {
        interactor.getAllTrails(callback: didGetAllTrails)
    }
    
    func transformTrailToTrailListingCard(_ trail: Trail) -> TrailListingCard {
        TrailListingCard(title: trail.title, tags: ["DISCOUNTED", "Most Popular"], lowestFeePerPax: 1_000,
                         tourDescription: trail.description, rating: trail.rating, numOfReviews: 389)
    }
    
    func populateTrailProfilePage(trailIndex: Int) {
        let trail = trails[trailIndex]
        router?.populateTrailProfilePageFor(trail: trail)
    }
}
