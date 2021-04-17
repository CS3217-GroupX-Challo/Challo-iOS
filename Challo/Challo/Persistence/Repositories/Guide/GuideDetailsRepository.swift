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

    init() {
        self.data = [NSManagedObjectID: GuidePersistenceObject]()
        self.repository = CoreDataRepository<GuideDetails>(managedObjectContext:
                                                            CoreDataContainer.managedObjectContext)
        self.areaRepository = CoreDataRepository<AreaDetails>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
        self.trailRepository = CoreDataRepository<TrailDetails>(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext)
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
        let currentGuides = getAll()
        let currentTrails = trailRepository.getAll()
        let currentAreas = areaRepository.getAll()
        
        let existingGuideObjects = objects.filter { guideObject in
            currentGuides.contains(guideObject)
        }
        
        let newGuideObjects = objects.filter { guideObject in
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
        
        if guideDetails.location == nil && guideObject.location != nil {
            let area = guideObject.location?.convertToEntity() as? AreaDetails
            guideDetails.location = area
        }
    }
    
    private func setTrails(guideDetails: GuideDetails,
                           guideObject: GuidePersistenceObject,
                           currentTrails: [TrailDetails]) {
        var trailsDetails = [TrailDetails]()
        for trail in guideObject.trails {
            var isSaved = false
            for trailDetail in currentTrails where trailDetail.id == trail.trailId.uuidString {
                trailsDetails.append(trailDetail)
                isSaved = true
                break
            }
            
            if !isSaved,
               let trailDetail = trail.convertToEntity() as? TrailDetails {
                trailsDetails.append(trailDetail)
            }
        }
        
        guideDetails.trails = NSSet(array: trailsDetails)
    }
}
