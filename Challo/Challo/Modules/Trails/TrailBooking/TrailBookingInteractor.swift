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
    private let bookingRepository: BookingRepositoryProtocol
    private let bookingAPI: BookingAPIProtocol
    private let userState: UserStateProtocol

    init(trailRepository: TrailRepositoryProtocol,
         guideRepository: GuideRepositoryProtocol,
         bookingRepository: BookingRepositoryProtocol,
         bookingAPI: BookingAPIProtocol,
         userState: UserStateProtocol) {
        self.trailRepository = trailRepository
        self.guideRepository = guideRepository
        self.bookingRepository = bookingRepository
        self.bookingAPI = bookingAPI
        self.userState = userState
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

    func makeBooking(bookingForm: TrailBookingForm,
                     callback: @escaping (Bool, Error?) -> Void) {
        guard let touristId = UUID(uuidString: userState.userId),
              userState.loggedIn else {
            ChalloLogger.logger.fault("User trying to make booking without signing in")
            callback(false, nil)
            return
        }

        let bookingDetails = BookingDetails(touristId: touristId,
                                            guideId: bookingForm.guideId,
                                            trailId: bookingForm.trailId,
                                            date: bookingForm.date,
                                            numberOfPax: bookingForm.numberOfPax,
                                            totalFee: bookingForm.totalFee)
        self.bookingAPI.makeBooking(bookingDetails: bookingDetails, callback: callback)
    }
}


extension TrailBookingInteractor {

    private func filterAvailableGuides(selectedDate: Date?) -> [Guide] {
        let availableGuides = originalGuides.filter { guide in
            guard let selectedDate = selectedDate else {
                return false
            }
    
            if let unavailableDates = guide.unavailableDates {
                if unavailableDates.contains(selectedDate) {
                    return false
                }
            }

            guard let dayOfWeek = selectedDate.dayOfWeek() else {
                ChalloLogger.logger.fault("Unable to get the day of week of selected booking date")
                return false
            }
            return guide.daysAvailable.contains(dayOfWeek)
        }

        return availableGuides
    }

    private func getExcludedDates() -> Set<Date> {
        var excludedDates = Set<Date>()
        var startDate = validDateRange.lowerBound
        let endDate = validDateRange.upperBound
        while startDate <= endDate {
            let guidesAvailable = filterAvailableGuides(selectedDate: startDate)
            if guidesAvailable.isEmpty {
                excludedDates.insert(startDate)
            }
            guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else {
                break
            }
            startDate = nextDay
        }
        return excludedDates
    }
}
