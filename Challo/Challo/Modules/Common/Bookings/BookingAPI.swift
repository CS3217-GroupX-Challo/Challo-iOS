//
//  BookingAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
import Dispatch

class BookingAPI: BookingAPIProtocol {

    typealias JSON = NetworkManager.JSON

    private let url = "/booking"
    private let bookingParser: BookingAPIParser
    private let networkManager: NetworkManager
    private let guideAPI: GuideAPI
    private let touristAPI: TouristAPI
    private let trailAPI: TrailAPI
    private let reviewAPI: ReviewAPI
    
    init(bookingParser: BookingAPIParser,
         networkManager: NetworkManager,
         guideAPI: GuideAPI,
         touristAPI: TouristAPI,
         trailAPI: TrailAPI,
         reviewAPI: ReviewAPI) {
        self.bookingParser = bookingParser
        self.networkManager = networkManager
        self.guideAPI = guideAPI
        self.touristAPI = touristAPI
        self.trailAPI = trailAPI
        self.reviewAPI = reviewAPI
    }

    func getBookingsForTourist(id: UUID, callback: @escaping ([Booking]) -> Void) {
        let fullURL = url + "/?touristId=\(id.uuidString)"
        getBookings(url: fullURL, callback: callback)
    }

    func getBookingsForGuide(id: UUID, callback: @escaping ([Booking]) -> Void) {
        let fullURL = url + "/?guideId=\(id.uuidString)"
        getBookings(url: fullURL, callback: callback)
    }
    
    private func getBookings(url: String, callback: @escaping ([Booking]) -> Void) {
        networkManager.get(url: url,
                           headers: [String: String]()) { [weak self] response, error in
            guard let self = self else {
                return
            }
            
            if error != nil {
                return
            }
            
            let bookingsJSON = self.bookingParser.extractBookingsJSON(response: response)
            var bookings = [Booking]()
            
            let bookingsGroup = DispatchGroup()
            bookingsJSON.forEach {
                self.handleBookingsJSON(json: $0, group: bookingsGroup) { booking in
                    bookings.append(booking)
                }
            }
            
            bookingsGroup.notify(queue: DispatchQueue.main) {
                callback(bookings)
            }
        }
    }

    private func handleBookingsJSON(json: JSON,
                                    group: DispatchGroup,
                                    callback: @escaping (Booking) -> Void) {
        group.enter()
        var guide: Guide?
        var tourist: Tourist?
        var trail: Trail?

        let internalGroup = DispatchGroup()
        guard let bookingID = bookingParser.extractBookingID(json: json),
              let guideID = bookingParser.extractGuideID(json: json),
              let touristID = bookingParser.extractTouristID(json: json),
              let trailID = bookingParser.extractTrailID(json: json) else {
            return
        }
        
        internalGroup.enter()
        guideAPI.getGuide(guideId: guideID) { retrievedGuide in
            guide = retrievedGuide
            internalGroup.leave()
        }
        
        internalGroup.enter()
        touristAPI.getTourist(userId: touristID) { retrievedTourist in
            tourist = retrievedTourist
            internalGroup.leave()
        }
    
        internalGroup.enter()
        trailAPI.getTrail(trailId: trailID) { retrievedTrail in
            trail = retrievedTrail
            internalGroup.leave()
        }
        
        internalGroup.notify(queue: DispatchQueue.global()) {
            guard let guide = guide,
                  let tourist = tourist,
                  let trail = trail else {
                return group.leave()
            }
            
            self.reviewAPI.getReviewForBooking(bookingId: bookingID,
                                               guide: guide,
                                               trail: trail,
                                               tourist: tourist) { review in
                guard let booking = self.bookingParser.convertJSONToBooking(json: json,
                                                                            guide: guide,
                                                                            trail: trail,
                                                                            tourist: tourist,
                                                                            review: review) else {
                    return group.leave()
                }
                callback(booking)
                group.leave()
            }
        }
    }
}

// MARK: Making bookings
extension BookingAPI {

    func makeBooking(bookingDetails: BookingDetails, callback: @escaping ((Bool, Error?) -> Void)) {
        let json = bookingDetails.convertToJSON()
        networkManager.post(url: url,
                            headers: [String: String](),
                            body: json) { response, err in
            if let error = err {
                callback(false, error)
                return
            }
            callback(true, nil)
        }
    }
}
