//
//  ReviewPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import CoreData
import Foundation

struct ReviewPersistenceObject {
    let reviewId: UUID
    let rating: Int
    let comment: String
    let guide: GuidePersistenceObject
    let trail: TrailPersistenceObject
    let createdAt: Date
    let tourist: TouristPersistenceObject
}

extension ReviewPersistenceObject: CoreDataPersistenceObject {
    init?(entity: NSManagedObject) {
        guard let review = entity as? ReviewDetails,
              let id = review.id,
              let reviewId = UUID(uuidString: id),
              let comment = review.comments,
              let createdAt = review.createdAt,
              let guideDetails = review.guide,
              let guideObject = GuidePersistenceObject(entity: guideDetails),
              let trailDetails = review.trail,
              let trailObject = TrailPersistenceObject(entity: trailDetails),
              let touristDetails = review.tourist,
              let touristObject = TouristPersistenceObject(entity: touristDetails) else {
            return nil
        }
        
        self.reviewId = reviewId
        self.rating = Int(review.rating)
        self.comment = comment
        self.guide = guideObject
        self.createdAt = createdAt
        self.tourist = touristObject
        self.trail = trailObject
    }
    
    func convertToEntity() -> NSManagedObject {
        let reviewDetails = ReviewDetails(context: CoreDataContainer.managedObjectContext)
        setReviewDetails(reviewDetails: reviewDetails)
        return reviewDetails
    }
    
    func updateEntity(entity: NSManagedObject) {
        guard let reviewDetails = entity as? ReviewDetails else {
            return
        }
        setReviewDetails(reviewDetails: reviewDetails)
    }
    
    private func setReviewDetails(reviewDetails: ReviewDetails) {
        reviewDetails.id = reviewId.uuidString
        reviewDetails.rating = Int64(rating)
        reviewDetails.comments = comment
        reviewDetails.createdAt = createdAt
    }
}

extension ReviewPersistenceObject: Equatable {
    static func == (lhs: ReviewPersistenceObject, rhs: ReviewPersistenceObject) -> Bool {
        lhs.reviewId == rhs.reviewId
    }
}
