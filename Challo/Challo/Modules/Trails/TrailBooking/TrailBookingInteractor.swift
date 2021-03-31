//
//  TrailBookingInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import Foundation
import Dispatch

class TrailBookingInteractor {

    private let trailRepository: TrailRepository
    private let guideRepository: GuideRepository
    private let bookingAPI: BookingAPI

    init(trailRepository: TrailRepository, guideRepository: GuideRepository, bookingAPI: BookingAPI) {
        self.trailRepository = trailRepository
        self.guideRepository = guideRepository
        self.bookingAPI = bookingAPI
    }

    func getGuidesForTrail(trailId: UUID, didRetrieveGuides: @escaping ([Guide]) -> Void) {
        let trailsRefreshed = DispatchGroup()
        // refresh the trails repo if necessary
        if trailRepository.getByKey(trailId) == nil {
            trailsRefreshed.enter()
            trailRepository.fetchTrailsAndRefresh { _ in
                trailsRefreshed.leave()
            }
        }
        
        trailsRefreshed.notify(queue: .main) { [weak self] in
            guard let trail = self?.trailRepository.getByKey(trailId) else {
                didRetrieveGuides([])
                return
            }
            
            // refresh the guide repo
            self?.guideRepository.fetchGuidesAndRefresh { [weak self] _ in
                let validGuides = trail.guideIds.compactMap { guideId in
                    self?.guideRepository.getByKey(guideId)
                }
                didRetrieveGuides(validGuides)
            }
        }
    }

    func makeBooking(bookingDetails: BookingDetails, callback: @escaping (Bool, Error?) -> Void) {
        self.bookingAPI.makeBooking(bookingDetails: bookingDetails, callback: callback)
    }
}
