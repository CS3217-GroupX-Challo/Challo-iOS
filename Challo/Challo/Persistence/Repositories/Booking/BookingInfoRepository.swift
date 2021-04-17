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
    private var guideRepository: GuideDetailsRepository
    private var trailRepository: TrailDetailsRepository
    private var touristRepository: TouristDetailsRepository
    private var reviewRepository: ReviewDetailsRepository
    
    init(data: [NSManagedObjectID: BookingPersistenceObject],
         repository: CoreDataRepository<BookingInfo>,
         guideRepository: GuideDetailsRepository,
         trailRepository: TrailDetailsRepository,
         touristRepository: TouristDetailsRepository,
         reviewRepository: ReviewDetailsRepository) {
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
            = GuideDetailsRepository()
        self.trailRepository
            = TrailDetailsRepository()
        self.reviewRepository
            = ReviewDetailsRepository()
        self.touristRepository
            = TouristDetailsRepository()
    }
    
    func getAll() -> [BookingPersistenceObject] {
        let bookings = repository.getAll()
        var bookingObjects = [BookingPersistenceObject]()
        self.data = [NSManagedObjectID: BookingPersistenceObject]()
        
        for booking in bookings {
            if let bookingObject = BookingPersistenceObject(entity: booking) {
                self.data[booking.objectID] = bookingObject
                bookingObjects.append(bookingObject)
            }
        }
        
        return bookingObjects
    }
    
    func save(objects: [BookingPersistenceObject]) {
        let currentBookings = getAll()
        let currentGuides = guideRepository.repository.getAll()
        let currentTourists = touristRepository.repository.getAll()
        let currentTrails = trailRepository.repository.getAll()
        let currentReviews = reviewRepository.repository.getAll()
        
        let existingBookingObjects = objects.filter { bookingObject in
            currentBookings.contains(bookingObject)
        }
        
        let newBookingObjects = objects.filter { bookingObject in
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
    
    private func saveGuidesInvolved(objects: [BookingPersistenceObject]) {
        let guideObjects = objects.compactMap { $0.guide }
        guideRepository.save(objects: guideObjects)
    }
    
    private func saveTouristsInvolved(objects: [BookingPersistenceObject]) {
        let touristObjects = objects.compactMap { $0.tourist }
        touristRepository.save(objects: touristObjects)
    }
    
    private func saveTrailsInvolved(objects: [BookingPersistenceObject]) {
        let trailsObjects = objects.compactMap { $0.trail }
        trailRepository.save(objects: trailsObjects)
    }
    
    private func saveReviewsInvolved(objects: [BookingPersistenceObject]) {
        let reviewObjects = objects.compactMap { $0.review }
        reviewRepository.save(objects: reviewObjects)
    }
    
    private func saveNewBookings(bookingObjects: [BookingPersistenceObject],
                                 currentGuides: [GuideDetails],
                                 currentTrails: [TrailDetails],
                                 currentTourists: [TouristDetails],
                                 currentReviews: [ReviewDetails]) {
        for bookingObject in bookingObjects {
            if let bookingInfo = bookingObject.convertToEntity() as? BookingInfo {
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
                bookingObject.updateEntity(entity: bookingInfo)
                setGuideTrailTouristReview(bookingInfo: bookingInfo,
                                           bookingObject: bookingObject,
                                           currentGuides: currentGuides,
                                           currentTrails: currentTrails,
                                           currentTourists: currentTourists,
                                           currentReviews: currentReviews)
            }
        }
    }
    
    // swiftlint:disable function_parameter_count
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
    }
    
    private func setTrail(bookingInfo: BookingInfo,
                          bookingObject: BookingPersistenceObject,
                          currentTrails: [TrailDetails]) {
        for trail in currentTrails where trail.id == bookingObject.trail.trailId.uuidString {
            bookingInfo.trail = trail
            break
        }
    }
    
    private func setTourist(bookingInfo: BookingInfo,
                            bookingObject: BookingPersistenceObject,
                            currentTourists: [TouristDetails]) {
        for tourist in currentTourists where tourist.id == bookingObject.tourist.userId.uuidString {
            bookingInfo.tourist = tourist
            break
        }
    }
    
    private func setReview(bookingInfo: BookingInfo,
                           bookingObject: BookingPersistenceObject,
                           currentReviews: [ReviewDetails]) {
        for review in currentReviews where review.id == bookingObject.review?.reviewId.uuidString {
            bookingInfo.review = review
            break
        }
    }
}
