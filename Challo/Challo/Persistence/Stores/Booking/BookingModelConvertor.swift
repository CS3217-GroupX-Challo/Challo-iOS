//
//  BookingModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

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
