//
//  TrailBookingInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 31/3/21.
//

import Foundation
import Dispatch

class TrailBookingInteractor: InteractorProtocol {

    weak var presenter: TrailBookingPresenter!

    private let trailRepository: TrailRepositoryProtocol
    private let guideRepository: GuideRepositoryProtocol
    private let bookingAPI: BookingAPIProtocol

    init(trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingAPI: BookingAPIProtocol) {
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
            self?.guideRepository.fetchGuidesAndRefresh { guides in
                let validGuides = guides.filter {
                    $0.trails.contains(trail)
                }
                didRetrieveGuides(validGuides)
            }
        }
    }

    func makeBooking(bookingDetails: BookingDetails, callback: @escaping (Bool, Error?) -> Void) {
        self.bookingAPI.makeBooking(bookingDetails: bookingDetails, callback: callback)
    }
}
