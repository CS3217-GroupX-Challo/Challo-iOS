//
//  TrailProfileRouter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfileRouter: RouterProtocol {
    
    weak var presenter: TrailProfilePresenter!
    var trailBookingPage: AnyView
    var trailBookingPresenter: TrailBookingPresenter

    init(trailProfilePresenter: TrailProfilePresenter,
         userState: UserStateProtocol,
         trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingAPI: BookingAPIProtocol) {
        let (view, presenter) = TrailBookingModule(trailProfilePresenter: trailProfilePresenter,
                                                   trailRepository: trailRepository,
                                                   guideRepository: guideRepository,
                                                   bookingAPI: bookingAPI,
                                                   userState: userState).assemble()
        self.trailBookingPage = view
        self.trailBookingPresenter = presenter
    }
}
