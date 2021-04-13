//
//  ReviewModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

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
