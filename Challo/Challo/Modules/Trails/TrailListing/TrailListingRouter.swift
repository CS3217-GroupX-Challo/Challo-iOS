//
//  TrailListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingRouter: ProfilableEntityListingRouter {
    typealias Entity = Trail
    
    weak var presenter: TrailListingPresenter!
    var profilePage: AnyView
    var trailProfilePresenter: TrailProfilePresenter
    
    init(userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingRepository: BookingRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         reviewAPI: ReviewAPIProtocol) {
        let (view, presenter) = TrailProfileModule(userState: userState,
                                                   trailRepository: trailRepository,
                                                   guideRepository: guideRepository,
                                                   bookingRepository: bookingRepository,
                                                   bookingAPI: bookingAPI,
                                                   reviewAPI: reviewAPI).assemble()
        profilePage = view
        trailProfilePresenter = presenter
    }
    
    func populateProfilePage(_ entity: Trail) {
        trailProfilePresenter.populateProfilePage(entity)
    }
    
}
