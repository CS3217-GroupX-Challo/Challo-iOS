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
    
    func getAllTrails() {
        self.trails = interactor.getAllTrails()
        trailListingCards = trails.map(transformTrailToTrailListingCard)
    }
    
    func transformTrailToTrailListingCard(_ trail: Trail) -> TrailListingCard {
        TrailListingCard(title: trail.title, tags: trail.tags, lowestFeePerPax: trail.lowestFee,
                         tourDescription: trail.description, rating: trail.rating, numOfReviews: trail.numOfReviews)
    }
    
    func populateTrailProfilePage(trailIndex: Int) {
        let trail = trails[trailIndex]
        router?.populateTrailProfilePageFor(trail: trail)
    }
}
