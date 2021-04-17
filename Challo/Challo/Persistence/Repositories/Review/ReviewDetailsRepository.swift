//
//  ReviewDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import CoreData
import Foundation

class ReviewDetailsRepository: ReviewDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: ReviewPersistenceObject]
    var repository: CoreDataRepository<ReviewDetails>
    private var guideRepository: GuideDetailsRepository
    private var trailRepository: TrailDetailsRepository
    private var touristRepository: TouristDetailsRepository
    
    init(data: [NSManagedObjectID: ReviewPersistenceObject],
         repository: CoreDataRepository<ReviewDetails>,
         guideRepository: GuideDetailsRepository,
         trailRepository: TrailDetailsRepository,
         touristRepository: TouristDetailsRepository) {
        self.data = data
        self.repository = repository
        self.guideRepository = guideRepository
        self.trailRepository = trailRepository
        self.touristRepository = touristRepository
    }
    
    init() {
        self.data = [NSManagedObjectID: ReviewPersistenceObject]()
        self.repository = CoreDataRepository<ReviewDetails>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
        self.guideRepository = GuideDetailsRepository()
        self.trailRepository = TrailDetailsRepository()
        self.touristRepository = TouristDetailsRepository()
    }
    
    func getAll() -> [ReviewPersistenceObject] {
        let reviews = repository.getAll()
        var reviewObjects = [ReviewPersistenceObject]()
        self.data = [NSManagedObjectID: ReviewPersistenceObject]()
        
        for review in reviews {
            if let reviewObject = ReviewPersistenceObject(entity: review) {
                self.data[review.objectID] = reviewObject
                reviewObjects.append(reviewObject)
            }
        }
        
        return reviewObjects
    }
    
    func save(objects: [ReviewPersistenceObject]) {
        let uniqueObjects = getUniqueReviews(objects: objects)
        saveCurrentDependencies(objects: uniqueObjects)
        
        let currentReviews = getAll()
        let currentGuides = guideRepository.repository.getAll()
        let currentTrails = trailRepository.repository.getAll()
        let currentTourists = touristRepository.repository.getAll()
        
        let existingReviewObjects = uniqueObjects.filter { reviewObject in
            currentReviews.contains(reviewObject)
        }
        
        let newReviewObjects = uniqueObjects.filter { reviewObject in
            !existingReviewObjects.contains(reviewObject)
        }
        
        saveNewReviews(reviewObjects: newReviewObjects,
                       currentTrails: currentTrails,
                       currentGuides: currentGuides,
                       currentTourists: currentTourists)
        updateReviews(reviewObjects: existingReviewObjects,
                      currentTrails: currentTrails,
                      currentGuides: currentGuides,
                      currentTourists: currentTourists)
        repository.commit()
    }
    
    private func getUniqueReviews(objects: [ReviewPersistenceObject]) -> [ReviewPersistenceObject] {
        var reviewsObjects = [ReviewPersistenceObject]()
        for object in objects {
            if !reviewsObjects.contains(object) {
                reviewsObjects.append(object)
            }
        }
        
        return reviewsObjects
    }
    
    private func saveCurrentDependencies(objects: [ReviewPersistenceObject]) {
        saveGuidesInvolved(objects: objects)
        saveTrailsInvolved(objects: objects)
        saveTouristsInvolved(objects: objects)
    }
    
    private func saveGuidesInvolved(objects: [ReviewPersistenceObject]) {
        let guideObjects = objects.compactMap { $0.guide }
        guideRepository.save(objects: guideObjects)
    }
    
    private func saveTrailsInvolved(objects: [ReviewPersistenceObject]) {
        let trailObjects = objects.compactMap { $0.trail }
        trailRepository.save(objects: trailObjects)
    }
    
    private func saveTouristsInvolved(objects: [ReviewPersistenceObject]) {
        let touristObjects = objects.compactMap { $0.tourist }
        touristRepository.save(objects: touristObjects)
    }
    
    private func setTrail(reviewDetails: ReviewDetails,
                          reviewObject: ReviewPersistenceObject,
                          currentTrails: [TrailDetails]) {
        for trail in currentTrails where trail.id == reviewObject.trail.trailId.uuidString {
            reviewDetails.trail = trail
            break
        }
    }
    
    private func saveNewReviews(reviewObjects: [ReviewPersistenceObject],
                                currentTrails: [TrailDetails],
                                currentGuides: [GuideDetails],
                                currentTourists: [TouristDetails]) {
        for reviewObject in reviewObjects {
            if let reviewDetails = reviewObject.convertToEntity() as? ReviewDetails {
                setReviewDetailsGuideTouristTrail(reviewObject: reviewObject,
                                                  reviewDetails: reviewDetails,
                                                  currentTrails: currentTrails,
                                                  currentGuides: currentGuides,
                                                  currentTourists: currentTourists)
            }
        }
    }
    
    private func updateReviews(reviewObjects: [ReviewPersistenceObject],
                               currentTrails: [TrailDetails],
                               currentGuides: [GuideDetails],
                               currentTourists: [TouristDetails]) {
        for reviewObject in reviewObjects {
            if let objectId = data.first(where: { $0.value == reviewObject })?.key,
               let reviewDetails = repository.getByKey(objectId) {
                reviewObject.updateEntity(entity: reviewDetails)
                setReviewDetailsGuideTouristTrail(reviewObject: reviewObject,
                                                  reviewDetails: reviewDetails,
                                                  currentTrails: currentTrails,
                                                  currentGuides: currentGuides,
                                                  currentTourists: currentTourists)
            }
        }
    }
    
    private func setReviewDetailsGuideTouristTrail(reviewObject: ReviewPersistenceObject,
                                                   reviewDetails: ReviewDetails,
                                                   currentTrails: [TrailDetails],
                                                   currentGuides: [GuideDetails],
                                                   currentTourists: [TouristDetails]) {
        setGuide(reviewDetails: reviewDetails,
                 reviewObject: reviewObject,
                 currentGuides: currentGuides)
        setTrail(reviewDetails: reviewDetails,
                 reviewObject: reviewObject,
                 currentTrails: currentTrails)
        setTourist(reviewDetails: reviewDetails,
                   reviewObject: reviewObject,
                   currentTourists: currentTourists)
    }
    
    private func setGuide(reviewDetails: ReviewDetails,
                          reviewObject: ReviewPersistenceObject,
                          currentGuides: [GuideDetails]) {
        for guide in currentGuides where guide.id == reviewObject.guide.userId.uuidString {
            reviewDetails.guide = guide
            break
        }
    }
    
    private func setTourist(reviewDetails: ReviewDetails,
                            reviewObject: ReviewPersistenceObject,
                            currentTourists: [TouristDetails]) {
        for tourist in currentTourists where tourist.id == reviewObject.tourist.userId.uuidString {
            reviewDetails.tourist = tourist
            break
        }
    }
}
