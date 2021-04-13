//
//  BookingModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

struct BookingModelConvertor {
    private let trailModelConvertor: TrailModelConvertor
    private let guideModelConvertor: GuideModelConvertor
    private let touristModelConvertor: TouristModelConvertor
    private let reviewModelConvertor: ReviewModelConvertor
    
    func convertBookingToBookingPersistenceObject(booking: Booking) -> BookingPersistenceObject {
        let trailObject
            = trailModelConvertor.convertTrailToTrailPersistenceObject(trail: booking.trail)
        let guideObject
            = guideModelConvertor.convertGuideToGuidePersistenceObject(guide: booking.guide)
        let touristObject
            = touristModelConvertor.convertTouristToTouristPersistenceObject(tourist: booking.tourist)
        
        var reviewObject: ReviewPersistenceObject?
        if let review = booking.review {
            reviewObject
                = reviewModelConvertor.convertReviewToReviewPersistenceObject(review: review)
        }
        
        return BookingPersistenceObject(bookingId: booking.bookingId, fee: booking.fee,
                                        date: booking.date, createdAt: booking.createdAt,
                                        status: booking.status, guide: guideObject,
                                        trail: trailObject, tourist: touristObject,
                                        review: reviewObject)
    }
    
    func convertBookingPersistenceObjectToBooking(bookingObject: BookingPersistenceObject) -> Booking {
        let trail
            = trailModelConvertor.convertTrailPersistenceObjectToTrail(trailObject: bookingObject.trail)
        let guide
            = guideModelConvertor.convertGuidePersistenceObject(guideObject: bookingObject.guide)
        let tourist
            = touristModelConvertor.convertTouristPersistenceObjectToTourist(touristObject:
                                                                                bookingObject.tourist)
        var review: Review?
        if let reviewObject = bookingObject.review {
            review = reviewModelConvertor.convertReviewPersistenceObjectToReview(reviewObject: reviewObject)
        }
        
        return Booking(bookingId: bookingObject.bookingId, fee: bookingObject.fee,
                       date: bookingObject.date, createdAt: bookingObject.createdAt,
                       status: bookingObject.status, guide: guide,
                       trail: trail, tourist: tourist,
                       review: review)
    }
}
