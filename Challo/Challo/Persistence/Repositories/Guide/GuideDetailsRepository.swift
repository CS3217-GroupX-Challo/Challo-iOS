//
//  GuideDetailsRepository.swift
//  Challo
//
//  Created by Kester Ng on 13/4/21.
//

import CoreData
import Foundation

class GuideDetailsRepository: GuideDetailsRepositoryProtocol {
    private var data: [NSManagedObjectID: GuidePersistenceObject]
    private var repository: CoreDataRepository<GuideDetails>
    private var areaRepository: CoreDataRepository<AreaDetails>
    private var trailRepository: CoreDataRepository<TrailDetails>
    
    init(data: [NSManagedObjectID: GuidePersistenceObject],
         repository: CoreDataRepository<GuideDetails>,
         areaRepository: CoreDataRepository<AreaDetails>,
         trailRepository: CoreDataRepository<TrailDetails>) {
        self.data = data
        self.repository = repository
        self.areaRepository = areaRepository
        self.trailRepository = trailRepository
    }
    
    func getAllGuides() -> [GuidePersistenceObject] {
        return []
    }
    
    func saveGuides(guideObjects: [GuidePersistenceObject]) {
    }
}
