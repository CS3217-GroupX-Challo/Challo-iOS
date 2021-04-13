//
//  BookingPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import CoreData
import Foundation

struct BookingPersistenceObject {
    let bookingId: UUID
    let fee: Double
    let date: Date
    let createdAt: Date
    let status: BookingStatus
    let guide: GuidePersistenceObject
    let trail: TrailPersistenceObject
    let tourist: TouristPersistenceObject
    let review: ReviewPersistenceObject?
}

extension BookingPersistenceObject: CoreDataPersistenceObject {
    init?(persistenceObject: NSManagedObject) {
        guard let booking = persistenceObject as? BookingInfo,
              let id = booking.id,
              let bookingId = UUID(uuidString: id),
              let date = booking.date,
              let createdAt = booking.createdAt,
              let statusString = booking.status,
              let status = BookingStatus(rawValue: statusString),
              let guideDetails = booking.guide,
              let guide = GuidePersistenceObject(persistenceObject: guideDetails),
              let trailDetails = booking.trail,
              let trail = TrailPersistenceObject(persistenceObject: trailDetails),
              let touristDetails = booking.tourist,
              let tourist = TouristPersistenceObject(persistenceObject: touristDetails) else {
            return nil
        }
        
        self.bookingId = bookingId
        self.fee = booking.fee
        self.date = date
        self.createdAt = createdAt
        self.status = status
        self.guide = guide
        self.trail = trail
        self.tourist = tourist
        
        if let reviewDetails = booking.review,
           let review = ReviewPersistenceObject(persistenceObject: reviewDetails) {
            self.review = review
        } else {
            self.review = nil
        }
    }
    
    func convertToPersistenceObject() -> NSManagedObject {
        let bookingInfo = BookingInfo(context: CoreDataContainer.managedObjectContext)
        setBookingInfo(bookingInfo: bookingInfo)
        return bookingInfo
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let bookingInfo = persistenceObject as? BookingInfo else {
            return
        }
        
        setBookingInfo(bookingInfo: bookingInfo)
    }
    
    private func setBookingInfo(bookingInfo: BookingInfo) {
        bookingInfo.createdAt = createdAt
        bookingInfo.date = date
        bookingInfo.id = bookingId.uuidString
        bookingInfo.fee = fee
        bookingInfo.status = status.rawValue
    }
}

extension BookingPersistenceObject: Equatable {
}
