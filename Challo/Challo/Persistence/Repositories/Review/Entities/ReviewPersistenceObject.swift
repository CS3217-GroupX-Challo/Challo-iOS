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
    init?(persistenceObject: NSManagedObject) {
        guard let review = persistenceObject as? ReviewDetails,
              let id = review.id,
              let reviewId = UUID(uuidString: id),
              let comment = review.comments,
              let createdAt = review.createdAt,
              let guideDetails = review.guide,
              let guideObject = GuidePersistenceObject(persistenceObject: guideDetails),
              let trailDetails = review.trail,
              let trailObject = TrailPersistenceObject(persistenceObject: trailDetails),
              let touristDetails = review.tourist,
              let touristObject = TouristPersistenceObject(persistenceObject: touristDetails) else {
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
    
    func convertToPersistenceObject() -> NSManagedObject {
        let reviewDetails = ReviewDetails(context: CoreDataContainer.managedObjectContext)
        setReviewDetails(reviewDetails: reviewDetails)
        return reviewDetails
    }
    
    func updatePersistenceObject(persistenceObject: NSManagedObject) {
        guard let reviewDetails = persistenceObject as? ReviewDetails else {
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
    
}
