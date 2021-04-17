//
//  BookingModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

/*
class BookingModelConvertor {
    private let trailModelConvertor: TrailModelConvertor
    private let guideModelConvertor: GuideModelConvertor
    private let touristModelConvertor: TouristModelConvertor
    private let reviewModelConvertor: ReviewModelConvertor
    
    init(trailModelConvertor: TrailModelConvertor,
         guideModelConvertor: GuideModelConvertor,
         touristModelConvertor: TouristModelConvertor,
         reviewModelConvertor: ReviewModelConvertor) {
        self.trailModelConvertor = trailModelConvertor
        self.guideModelConvertor = guideModelConvertor
        self.reviewModelConvertor = reviewModelConvertor
        self.touristModelConvertor = touristModelConvertor
    }
    
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
}*/

class BookingModelConvertor: ModelConvertor {
    typealias Model = Booking
    typealias PersistenceObject = BookingPersistenceObject
    
    private let trailModelConvertor: TrailModelConvertor
    private let guideModelConvertor: GuideModelConvertor
    private let touristModelConvertor: TouristModelConvertor
    private let reviewModelConvertor: ReviewModelConvertor
    
    init(trailModelConvertor: TrailModelConvertor,
         guideModelConvertor: GuideModelConvertor,
         touristModelConvertor: TouristModelConvertor,
         reviewModelConvertor: ReviewModelConvertor) {
        self.trailModelConvertor = trailModelConvertor
        self.guideModelConvertor = guideModelConvertor
        self.reviewModelConvertor = reviewModelConvertor
        self.touristModelConvertor = touristModelConvertor
    }
    
    func convertModelToPersistenceObject(model: Booking) -> BookingPersistenceObject {
        let trailObject
            = trailModelConvertor.convertModelToPersistenceObject(model: model.trail)
        let guideObject
            = guideModelConvertor.convertModelToPersistenceObject(model: model.guide)
        let touristObject
            = touristModelConvertor.convertModelToPersistenceObject(model: model.tourist)
        
        var reviewObject: ReviewPersistenceObject?
        if let review = model.review {
            reviewObject
                = reviewModelConvertor.convertModelToPersistenceObject(model: review)
        }
        
        return BookingPersistenceObject(bookingId: model.bookingId, fee: model.fee,
                                        date: model.date, createdAt: model.createdAt,
                                        status: model.status, guide: guideObject,
                                        trail: trailObject, tourist: touristObject,
                                        review: reviewObject)
    }
    
    func convertPersistenceObjectToModel(object: BookingPersistenceObject) -> Booking {
        let trail
            = trailModelConvertor.convertPersistenceObjectToModel(object: object.trail)
        let guide
            = guideModelConvertor.convertPersistenceObjectToModel(object: object.guide)
        let tourist
            = touristModelConvertor.convertPersistenceObjectToModel(object: object.tourist)
        var review: Review?
        if let reviewObject = object.review {
            review = reviewModelConvertor.convertPersistenceObjectToModel(object: reviewObject)
        }
        
        return Booking(bookingId: object.bookingId, fee: object.fee,
                       date: object.date, createdAt: object.createdAt,
                       status: object.status, guide: guide,
                       trail: trail, tourist: tourist,
                       review: review)
    }
}
