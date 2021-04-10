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
    private var originalGuides = [Guide]()
    private var datesWithExistingBookings = Set<Date>()
    private var guidesExistingBookingDates = [UUID: [Date]]()

    var validDateRange: ClosedRange<Date> {
        let today = Calendar.current.startOfDay(for: Date())
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: today) ?? today
        let sixMonthsLater = Calendar.current.date(byAdding: .month, value: 6, to: nextDay) ?? today
        return nextDay...sixMonthsLater
    }

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

    func setUp(trailId: UUID, setUpDidComplete: @escaping () -> Void) {
        getExistingBookings { [weak self] bookings in
            self?.datesWithExistingBookings = Set(bookings.map { $0.date.convertToStartOfDay() })
            self?.getGuidesForTrail(trailId: trailId) { guides in
                self?.originalGuides = guides
                self?.getGuidesBookingDates(guides: guides) { guidesBookingDates in
                    self?.guidesExistingBookingDates = guidesBookingDates
                    setUpDidComplete()
                }
            }
        }
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

    func getExistingBookings(didRetrieveBookings: @escaping ([Booking]) -> Void) {
        guard let userId = UUID(uuidString: userState.userId) else {
            return
        }
        bookingRepository.fetchBookingForTouristAndRefresh(id: userId) { bookings in
            didRetrieveBookings(bookings)
        }
    }

    func getGuidesBookingDates(guides: [Guide], didComplete: @escaping ([UUID: [Date]]) -> Void) {
        if guides.isEmpty {
            return
        }

        var guidesBookingDates = [UUID: [Date]]()
        let group = DispatchGroup()
        for _ in 0..<guides.count {
            group.enter()
        }

        for guide in guides {
            bookingRepository.fetchBookingForGuideAndRefresh(id: guide.userId) { bookings in
                guidesBookingDates[guide.userId] = bookings.map { $0.date.convertToStartOfDay() }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            didComplete(guidesBookingDates)
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

    func filterAvailableGuides(selectedDate: Date?) -> [Guide] {
        guard let selectedDate = selectedDate?.convertToStartOfDay() else {
            return []
        }

        let availableGuides = originalGuides.filter { guide in
    
            if let unavailableDates = guide.unavailableDates {
                if unavailableDates.contains(selectedDate) {
                    return false
                }
            }
            
            guard let daysWithBookings = guidesExistingBookingDates[guide.userId] else {
                return true
            }
            
            if daysWithBookings.contains(selectedDate) {
                return false
            }

            guard let dayOfWeek = selectedDate.dayOfWeek() else {
                ChalloLogger.logger.fault("Unable to get the day of week of selected booking date")
                return false
            }
            return guide.daysAvailable.contains(dayOfWeek)
        }

        return availableGuides
    }

    func getExcludedDates() -> Set<Date> {
        var excludedDates = Set<Date>()
        var startDate = validDateRange.lowerBound
        let endDate = validDateRange.upperBound
        while startDate <= endDate {
            guard let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: startDate) else {
                break
            }
    
            if datesWithExistingBookings.contains(startDate) {
                excludedDates.insert(startDate)
                startDate = nextDay
                continue
            }

            let guidesAvailable = filterAvailableGuides(selectedDate: startDate)
            if guidesAvailable.isEmpty {
                excludedDates.insert(startDate)
            }

            startDate = nextDay
        }
        return excludedDates
    }
}
