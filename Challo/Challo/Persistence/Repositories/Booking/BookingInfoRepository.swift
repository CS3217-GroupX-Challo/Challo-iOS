//
//  BookingInfoRepository.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import CoreData
import Foundation

class BookingInfoRepository: BookingInfoRepositoryProtocol {
    private var data: [NSManagedObjectID: BookingPersistenceObject]
    private var repository: CoreDataRepository<BookingInfo>
    private var guideRepository: CoreDataRepository<GuideDetails>
    private var trailRepository: CoreDataRepository<TrailDetails>
    private var touristRepository: CoreDataRepository<TouristDetails>
    private var reviewRepository: CoreDataRepository<ReviewDetails>
    
    init(data: [NSManagedObjectID: BookingPersistenceObject],
         repository: CoreDataRepository<BookingInfo>,
         guideRepository: CoreDataRepository<GuideDetails>,
         trailRepository: CoreDataRepository<TrailDetails>,
         touristRepository: CoreDataRepository<TouristDetails>,
         reviewRepository: CoreDataRepository<ReviewDetails>) {
        self.data = data
        self.repository = repository
        self.guideRepository = guideRepository
        self.reviewRepository = reviewRepository
        self.trailRepository = trailRepository
        self.touristRepository = touristRepository
    }
    
    init() {
        data = [NSManagedObjectID: BookingPersistenceObject]()
        self.repository
            = CoreDataRepository<BookingInfo>(managedObjectContext: CoreDataContainer.managedObjectContext)
        self.guideRepository
            = CoreDataRepository<GuideDetails>(managedObjectContext: CoreDataContainer.managedObjectContext)
        self.trailRepository
            = CoreDataRepository<TrailDetails>(managedObjectContext: CoreDataContainer.managedObjectContext)
        self.reviewRepository
            = CoreDataRepository<ReviewDetails>(managedObjectContext: CoreDataContainer.managedObjectContext)
        self.touristRepository
            = CoreDataRepository<TouristDetails>(managedObjectContext: CoreDataContainer.managedObjectContext)
    }
    
    func getAllBookings() -> [BookingPersistenceObject] {
        /*  let reviews = repository.getAll()
         var reviewObjects = [ReviewPersistenceObject]()
         self.data = [NSManagedObjectID: ReviewPersistenceObject]()
         
         for review in reviews {
             if let reviewObject = ReviewPersistenceObject(persistenceObject: review) {
                 self.data[review.objectID] = reviewObject
                 reviewObjects.append(reviewObject)
             }
         }
         
         return reviewObjects*/
        let bookings = repository.getAll()
        var bookingObjects = [BookingPersistenceObject]()
        self.data = [NSManagedObjectID: BookingPersistenceObject]()
        
        for booking in bookings {
            if let bookingObject = BookingPersistenceObject(persistenceObject: booking) {
                self.data[booking.objectID] = bookingObject
                bookingObjects.append(bookingObject)
            }
        }
        
        return bookingObjects
    }
    
    func saveBookings(bookingObjects: [BookingPersistenceObject]) {
        let currentBookings = getAllBookings()
        let currentGuides = guideRepository.getAll()
        let currentTourists = touristRepository.getAll()
        let currentTrails = trailRepository.getAll()
        let currentReviews = reviewRepository.getAll()
        
        let existingBookingObjects = bookingObjects.filter { bookingObject in
            currentBookings.contains(bookingObject)
        }
        
        let newBookingObjects = bookingObjects.filter { bookingObject in
            !existingBookingObjects.contains(bookingObject)
        }
        
        saveNewBookings(bookingObjects: newBookingObjects,
                        currentGuides: currentGuides,
                        currentTrails: currentTrails,
                        currentTourists: currentTourists,
                        currentReviews: currentReviews)
        updateBookings(bookingObjects: existingBookingObjects,
                       currentGuides: currentGuides,
                       currentTrails: currentTrails,
                       currentTourists: currentTourists,
                       currentReviews: currentReviews)
    }
    
    private func saveNewBookings(bookingObjects: [BookingPersistenceObject],
                                 currentGuides: [GuideDetails],
                                 currentTrails: [TrailDetails],
                                 currentTourists: [TouristDetails],
                                 currentReviews: [ReviewDetails]) {
        for bookingObject in bookingObjects {
            if let bookingInfo = bookingObject.convertToPersistenceObject() as? BookingInfo {
                setGuideTrailTouristReview(bookingInfo: bookingInfo,
                                           bookingObject: bookingObject,
                                           currentGuides: currentGuides,
                                           currentTrails: currentTrails,
                                           currentTourists: currentTourists,
                                           currentReviews: currentReviews)
            }
        }
    }
    
    private func updateBookings(bookingObjects: [BookingPersistenceObject],
                                currentGuides: [GuideDetails],
                                currentTrails: [TrailDetails],
                                currentTourists: [TouristDetails],
                                currentReviews: [ReviewDetails]) {
        for bookingObject in bookingObjects {
            if let objectId = data.first(where: { $0.value == bookingObject })?.key,
               let bookingInfo = repository.getByKey(objectId) {
                bookingObject.updatePersistenceObject(persistenceObject: bookingInfo)
                setGuideTrailTouristReview(bookingInfo: bookingInfo,
                                           bookingObject: bookingObject,
                                           currentGuides: currentGuides,
                                           currentTrails: currentTrails,
                                           currentTourists: currentTourists,
                                           currentReviews: currentReviews)
            }
        }
    }
    
    private func setGuideTrailTouristReview(bookingInfo: BookingInfo,
                                            bookingObject: BookingPersistenceObject,
                                            currentGuides: [GuideDetails],
                                            currentTrails: [TrailDetails],
                                            currentTourists: [TouristDetails],
                                            currentReviews: [ReviewDetails]) {
        setGuide(bookingInfo: bookingInfo,
                 bookingObject: bookingObject,
                 currentGuides: currentGuides)
        setTrail(bookingInfo: bookingInfo,
                 bookingObject: bookingObject,
                 currentTrails: currentTrails)
        setReview(bookingInfo: bookingInfo,
                  bookingObject: bookingObject,
                  currentReviews: currentReviews)
        setTourist(bookingInfo: bookingInfo,
                   bookingObject: bookingObject,
                   currentTourists: currentTourists)
    }
    
    private func setGuide(bookingInfo: BookingInfo,
                          bookingObject: BookingPersistenceObject,
                          currentGuides: [GuideDetails]) {
        for guide in currentGuides where guide.id == bookingObject.guide.userId.uuidString {
            bookingInfo.guide = guide
            break
        }
        
        if bookingInfo.guide == nil {
            let guide = bookingObject.guide.convertToPersistenceObject() as? GuideDetails
            bookingInfo.guide = guide
        }
    }
    
    private func setTrail(bookingInfo: BookingInfo,
                          bookingObject: BookingPersistenceObject,
                          currentTrails: [TrailDetails]) {
        for trail in currentTrails where trail.id == bookingObject.trail.trailId.uuidString {
            bookingInfo.trail = trail
            break
        }
        
        if bookingInfo.trail == nil {
            let trail = bookingObject.trail.convertToPersistenceObject() as? TrailDetails
            bookingInfo.trail = trail
        }
    }
    
    private func setTourist(bookingInfo: BookingInfo,
                            bookingObject: BookingPersistenceObject,
                            currentTourists: [TouristDetails]) {
        for tourist in currentTourists where tourist.id == bookingObject.tourist.userId.uuidString {
            bookingInfo.tourist = tourist
            break
        }
        
        if bookingInfo.tourist == nil {
            let tourist = bookingObject.tourist.convertToPersistenceObject() as? TouristDetails
            bookingInfo.tourist = tourist
        }
    }
    
    private func setReview(bookingInfo: BookingInfo,
                           bookingObject: BookingPersistenceObject,
                           currentReviews: [ReviewDetails]) {
        for review in currentReviews where review.id == bookingObject.review?.reviewId.uuidString {
            bookingInfo.review = review
            break
        }
        
        if bookingInfo.review == nil {
            let review = bookingObject.review?.convertToPersistenceObject() as? ReviewDetails
            bookingInfo.review = review
        }
    }
}
