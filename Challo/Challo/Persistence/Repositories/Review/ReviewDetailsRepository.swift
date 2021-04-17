//
//  ReviewDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import CoreData

class ReviewDetailsRepository: ReviewDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: ReviewPersistenceObject]
    private var repository: CoreDataRepository<ReviewDetails>
    private var guideRepository: CoreDataRepository<GuideDetails>
    private var trailRepository: CoreDataRepository<TrailDetails>
    private var touristRepository: CoreDataRepository<TouristDetails>
    
    init(data: [NSManagedObjectID: ReviewPersistenceObject],
         repository: CoreDataRepository<ReviewDetails>,
         guideRepository: CoreDataRepository<GuideDetails>,
         trailRepository: CoreDataRepository<TrailDetails>,
         touristRepository: CoreDataRepository<TouristDetails>) {
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
        self.guideRepository = CoreDataRepository<GuideDetails>(managedObjectContext:
                                                                    CoreDataContainer.managedObjectContext)
        self.trailRepository = CoreDataRepository<TrailDetails>(managedObjectContext:
                                                                    CoreDataContainer.managedObjectContext)
        self.touristRepository = CoreDataRepository<TouristDetails>(managedObjectContext:
                                                                        CoreDataContainer.managedObjectContext)
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
        let currentReviews = getAll()
        let currentGuides = guideRepository.getAll()
        let currentTrails = trailRepository.getAll()
        let currentTourists = touristRepository.getAll()
        
        let existingReviewObjects = objects.filter { reviewObject in
            currentReviews.contains(reviewObject)
        }
        
        let newReviewObjects = objects.filter { reviewObject in
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
    
    private func setTrail(reviewDetails: ReviewDetails,
                          reviewObject: ReviewPersistenceObject,
                          currentTrails: [TrailDetails]) {
        for trail in currentTrails where trail.id == reviewObject.trail.trailId.uuidString {
            reviewDetails.trail = trail
            break
        }
        
        // trail has not been saved in core data repository, time to save
        if reviewDetails.trail == nil {
            let trail = reviewObject.trail.convertToEntity() as? TrailDetails
            reviewDetails.trail = trail
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
        
        if reviewDetails.guide == nil {
            let guide = reviewObject.guide.convertToEntity() as? GuideDetails
            reviewDetails.guide = guide
        }
    }
    
    private func setTourist(reviewDetails: ReviewDetails,
                            reviewObject: ReviewPersistenceObject,
                            currentTourists: [TouristDetails]) {
        for tourist in currentTourists where tourist.id == reviewObject.tourist.userId.uuidString {
            reviewDetails.tourist = tourist
            break
        }
        
        if reviewDetails.tourist == nil {
            let tourist = reviewObject.tourist.convertToEntity() as? TouristDetails
            reviewDetails.tourist = tourist
        }
    }
}
