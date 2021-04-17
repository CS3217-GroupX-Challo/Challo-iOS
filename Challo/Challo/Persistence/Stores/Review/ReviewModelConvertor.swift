//
//  ReviewModelConvertor.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

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
