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

    var repository: CoreDataRepository<GuideDetails>
    private var areaRepository: AreaDetailsRepository
    private var trailRepository: TrailDetailsRepository

    init(data: [NSManagedObjectID: GuidePersistenceObject],
         repository: CoreDataRepository<GuideDetails>,
         areaRepository: AreaDetailsRepository,
         trailRepository: TrailDetailsRepository) {
        self.data = data
        self.repository = repository
        self.areaRepository = areaRepository
        self.trailRepository = trailRepository
    }

    init() {
        self.data = [NSManagedObjectID: GuidePersistenceObject]()
        self.repository = CoreDataRepository<GuideDetails>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
        self.areaRepository = AreaDetailsRepository()
        self.trailRepository = TrailDetailsRepository()
    }
    
    func getAll() -> [GuidePersistenceObject] {
        let guides = repository.getAll()
        var guideObjects = [GuidePersistenceObject]()
        self.data = [NSManagedObjectID: GuidePersistenceObject]()
        
        for guide in guides {
            if let guideObject = GuidePersistenceObject(entity: guide) {
                self.data[guide.objectID] = guideObject
                guideObjects.append(guideObject)
            }
        }
        
        return guideObjects
    }
    
    func save(objects: [GuidePersistenceObject]) {
        let uniqueObjects = getUniqueGuides(objects: objects)

        saveTrailsInvolved(objects: uniqueObjects)
        saveAreasInvolved(objects: uniqueObjects)
        
        let currentGuides = getAll()
        let currentTrails = trailRepository.repository.getAll()
        let currentAreas = areaRepository.repository.getAll()
        
        let existingGuideObjects = uniqueObjects.filter { guideObject in
            currentGuides.contains(guideObject)
        }
        
        let newGuideObjects = uniqueObjects.filter { guideObject in
            !existingGuideObjects.contains(guideObject)
        }
        
        saveNewGuides(guideObjects: newGuideObjects,
                      currentAreas: currentAreas,
                      currentTrails: currentTrails)
        updateGuides(guideObjects: existingGuideObjects,
                     currentAreas: currentAreas,
                     currentTrails: currentTrails)
        repository.commit()
    }

    private func getUniqueGuides(objects: [GuidePersistenceObject]) -> [GuidePersistenceObject] {
        var uniqueId = Set<UUID>()
        var uniqueObjects = [GuidePersistenceObject]()

        objects.forEach {
            if uniqueId.contains($0.userId) {
                return
            }
            uniqueId.insert($0.userId)
            uniqueObjects.append($0)
        }
        
        return uniqueObjects
    }

    private func saveTrailsInvolved(objects: [GuidePersistenceObject]) {
        let allTrails = objects.flatMap { $0.trails }
        trailRepository.save(objects: allTrails)
    }

    private func saveAreasInvolved(objects: [GuidePersistenceObject]) {
        let allAreas = objects.compactMap { $0.location }
        areaRepository.save(objects: allAreas)
    }
    
    private func saveNewGuides(guideObjects: [GuidePersistenceObject],
                               currentAreas: [AreaDetails],
                               currentTrails: [TrailDetails]) {
        for guideObject in guideObjects {
            if let guideDetails = guideObject.convertToEntity() as? GuideDetails {
                setArea(guideDetails: guideDetails,
                        guideObject: guideObject,
                        currentAreas: currentAreas)
                setTrails(guideDetails: guideDetails,
                          guideObject: guideObject,
                          currentTrails: currentTrails)
            }
        }
    }
    
    private func updateGuides(guideObjects: [GuidePersistenceObject],
                              currentAreas: [AreaDetails],
                              currentTrails: [TrailDetails]) {
        for guideObject in guideObjects {
            if let objectId = data.first(where: { $0.value == guideObject })?.key,
               let guide = repository.getByKey(objectId) {
                guideObject.updateEntity(entity: guide)
                setArea(guideDetails: guide,
                        guideObject: guideObject,
                        currentAreas: currentAreas)
                setTrails(guideDetails: guide,
                          guideObject: guideObject,
                          currentTrails: currentTrails)
            }
        }
    }
    
    private func setArea(guideDetails: GuideDetails,
                         guideObject: GuidePersistenceObject,
                         currentAreas: [AreaDetails]) {
        for area in currentAreas where area.id == guideObject.location?.areaId.uuidString {
            guideDetails.location = area
            break
        }
    }
    
    private func setTrails(guideDetails: GuideDetails,
                           guideObject: GuidePersistenceObject,
                           currentTrails: [TrailDetails]) {
        var trailsDetails = [TrailDetails]()
        for trail in guideObject.trails {
            for trailDetail in currentTrails where trailDetail.id == trail.trailId.uuidString {
                trailsDetails.append(trailDetail)
                break
            }
        }
        
        guideDetails.trails = NSSet(array: trailsDetails)
    }
}
