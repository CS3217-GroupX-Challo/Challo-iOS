//
//  ReviewModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

/*
class ReviewModelConvertor {
    private let guideModelConvertor: GuideModelConvertor
    private let touristModelConvertor: TouristModelConvertor
    private let trailModelConvertor: TrailModelConvertor
    
    init(guideModelConvertor: GuideModelConvertor,
         touristModelConvertor: TouristModelConvertor,
         trailModelConvertor: TrailModelConvertor) {
        self.guideModelConvertor = guideModelConvertor
        self.trailModelConvertor = trailModelConvertor
        self.touristModelConvertor = touristModelConvertor
    }
    
    func convertReviewToReviewPersistenceObject(review: Review) -> ReviewPersistenceObject {
        let guideObject
            = guideModelConvertor.convertGuideToGuidePersistenceObject(guide: review.guide)
        let touristObject
            = touristModelConvertor.convertTouristToTouristPersistenceObject(tourist: review.tourist)
        let trailObject
            = trailModelConvertor.convertTrailToTrailPersistenceObject(trail: review.trail)
        return ReviewPersistenceObject(reviewId: review.reviewId, rating: review.rating,
                                       comment: review.comment, guide: guideObject,
                                       trail: trailObject, createdAt: review.createdAt,
                                       tourist: touristObject)
    }
    
    func convertReviewPersistenceObjectToReview(reviewObject: ReviewPersistenceObject) -> Review {
        let guide
            = guideModelConvertor.convertGuidePersistenceObject(guideObject: reviewObject.guide)
        let tourist
            = touristModelConvertor.convertTouristPersistenceObjectToTourist(touristObject: reviewObject.tourist)
        let trail
            = trailModelConvertor.convertTrailPersistenceObjectToTrail(trailObject: reviewObject.trail)
        return Review(reviewId: reviewObject.reviewId, rating: reviewObject.rating,
                      comment: reviewObject.comment, guide: guide,
                      trail: trail, createdAt: reviewObject.createdAt,
                      tourist: tourist)
    }
}
*/

class ReviewModelConvertor: ModelConvertor {
    typealias Model = Review
    typealias PersistenceObject = ReviewPersistenceObject
    
    private let guideModelConvertor: GuideModelConvertor
    private let touristModelConvertor: TouristModelConvertor
    private let trailModelConvertor: TrailModelConvertor
    
    init(guideModelConvertor: GuideModelConvertor,
         touristModelConvertor: TouristModelConvertor,
         trailModelConvertor: TrailModelConvertor) {
        self.guideModelConvertor = guideModelConvertor
        self.trailModelConvertor = trailModelConvertor
        self.touristModelConvertor = touristModelConvertor
    }
    
    func convertModelToPersistenceObject(model: Review) -> ReviewPersistenceObject {
        let guideObject
            = guideModelConvertor.convertModelToPersistenceObject(model: model.guide)
        let touristObject
            = touristModelConvertor.convertModelToPersistenceObject(model: model.tourist)
        let trailObject
            = trailModelConvertor.convertModelToPersistenceObject(model: model.trail)
        return ReviewPersistenceObject(reviewId: model.reviewId, rating: model.rating,
                                       comment: model.comment, guide: guideObject,
                                       trail: trailObject, createdAt: model.createdAt,
                                       tourist: touristObject)
    }
    
    func convertPersistenceObjectToModel(object: ReviewPersistenceObject) -> Review {
        let guide
            = guideModelConvertor.convertPersistenceObjectToModel(object: object.guide)
        let tourist
            = touristModelConvertor.convertPersistenceObjectToModel(object: object.tourist)
        let trail
            = trailModelConvertor.convertPersistenceObjectToModel(object: object.trail)
        return Review(reviewId: object.reviewId, rating: object.rating,
                      comment: object.comment, guide: guide,
                      trail: trail, createdAt: object.createdAt,
                      tourist: tourist)
    }
}
