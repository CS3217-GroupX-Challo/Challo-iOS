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
        return []
    }
    
    func saveBookings(bookingObjects: [BookingPersistenceObject]) {
    }
}
