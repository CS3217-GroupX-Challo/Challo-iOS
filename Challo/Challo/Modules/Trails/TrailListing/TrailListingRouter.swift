//
//  TrailListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingRouter: RouterProtocol {
    
    weak var presenter: TrailListingPresenter!
    var trailProfilePage: AnyView
    var trailProfilePresenter: TrailProfilePresenter
    
    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         reviewAPI: ReviewAPIProtocol) {
        let (view, presenter) = TrailProfileModule(userState: userState,
                                                   trailRepository: trailRepository,
                                                   guideRepository: guideRepository,
                                                   bookingAPI: bookingAPI,
                                                   reviewAPI: reviewAPI).assemble()
        trailProfilePage = view
        trailProfilePresenter = presenter
    }
    
    func populateTrailProfilePageFor(trail: Trail) {
        trailProfilePresenter.populateTrailProfilePageFor(trail: trail)
    }
    
}
