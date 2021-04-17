//
//  MapMarkerRepository.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import CoreData
import Foundation

// MARK: - Extension from MapMarkerRepositoryInterface
class MapMarkerRepository: MapMarkerRepositoryInterface {
    
    private var data: [NSManagedObjectID: MarkerPersistenceObject]
    private var repository: CoreDataRepository<Marker>
    
    init(data: [NSManagedObjectID: MarkerPersistenceObject], repository: CoreDataRepository<Marker>) {
        self.data = data
        self.repository = repository
    }
    
    init() {
        self.data = [NSManagedObjectID: MarkerPersistenceObject]()
        self.repository = CoreDataRepository<Marker>(managedObjectContext: CoreDataContainer.managedObjectContext)
    }
    
    func getAllMarkers() -> [MarkerPersistenceObject] {
        data = [NSManagedObjectID: MarkerPersistenceObject]() // reset data
        let result = repository.getAll()
        var markerObjects = [MarkerPersistenceObject]()
        
        for marker in result {
            if let markerObject = MarkerPersistenceObject(entity: marker) {
                data[marker.objectID] = markerObject
                markerObjects.append(markerObject)
            }
        }
        
        return markerObjects
    }
    
    func saveMarkers(markerObjects: [MarkerPersistenceObject]) {
        let savedMapMarkers = getAllMarkers()
        let markerObjectsToUpdate = markerObjects.filter { markerObject in
            savedMapMarkers.contains(markerObject)
        }
        
        let toSaveMarkerObjects = markerObjects.filter { markerObject in
            !markerObjectsToUpdate.contains(markerObject)
        }
        
        updateMarkers(markerObjects: markerObjectsToUpdate)
        saveNewMarkers(markerObjects: toSaveMarkerObjects)
        repository.commit()
    }
    
    private func updateMarkers(markerObjects: [MarkerPersistenceObject]) {
        for markerObject in markerObjects {
            if let objectId = data.first(where: { $0.value == markerObject })?.key,
               let managedObject = repository.getByKey(objectId) {
                markerObject.updateEntity(entity: managedObject)
            }
        }
    }
    
    private func saveNewMarkers(markerObjects: [MarkerPersistenceObject]) {
        for markerObject in markerObjects {
            _ = markerObject.convertToEntity()
        }
    }
    
    static func convertMarkerObjectToMapMarker(marker: Marker) -> MapMarker {
        MapMarker(id: UUID(uuidString: marker.id ?? "") ?? UUID(),
                  position: CLLocationCoordinate2D(latitude: marker.latitude,
                                                   longitude: marker.longitude),
                  date: marker.date,
                  comments: marker.comments)
    }
}
