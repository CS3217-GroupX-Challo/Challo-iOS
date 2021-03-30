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
    
    private var data: [NSManagedObjectID: MapMarker]
    private var repository: CoreDataRepository<Marker>
    private var container: CoreDataContainer
    
    init() {
        self.data = [NSManagedObjectID: MapMarker]()
        let container = CoreDataContainer()
        self.container = container
        self.repository = CoreDataRepository<Marker>(managedObjectContext: container.managedObjectContext)
    }
    
    func getAllMapMarkers() -> [MapMarker] {
        data = [NSManagedObjectID: MapMarker]() // reset data
        let result = repository.getAll()
        return result.map { marker in
            let mapMarker = convertMarkerObjectToMapMarker(marker: marker)
            data[marker.objectID] = mapMarker
            return mapMarker
        }
    }
    
    func saveMapMarkers(mapMarkers: [MapMarker]) {
        let savedMapMarkers = getAllMapMarkers()
        let mapMarkersToUpdate = mapMarkers.filter { mapMarker in
            savedMapMarkers.contains(mapMarker)
        }
        
        let toSaveMapMarkers = mapMarkers.filter { mapMarker in
            !mapMarkersToUpdate.contains(mapMarker)
        }
        
        updateMapMarkers(mapMarkers: mapMarkersToUpdate)
        saveNewMapMarkers(mapMarkers: toSaveMapMarkers)
    }
    
    private func updateMapMarkers(mapMarkers: [MapMarker]) {
        for mapMaker in mapMarkers {
            if let objectId = data.first(where: { $0.value == mapMaker })?.key,
               let managedObject = repository.getByKey(objectId) {
                managedObject.setValue(mapMaker.id.uuidString, forKey: "id")
                managedObject.setValue(mapMaker.position.latitude, forKey: "latitude")
                managedObject.setValue(mapMaker.position.longitude, forKey: "longitude")
                managedObject.setValue(mapMaker.date, forKey: "date")
                managedObject.setValue(mapMaker.comments, forKey: "comments")
                repository.updateByKey(entity: managedObject, key: objectId)
            }
        }
    }
    
    private func saveNewMapMarkers(mapMarkers: [MapMarker]) {
        for mapMarker in mapMarkers {
            let marker = Marker(context: container.managedObjectContext)
            marker.id = mapMarker.id.uuidString
            marker.comments = mapMarker.comments
            marker.longitude = mapMarker.position.longitude
            marker.latitude = mapMarker.position.latitude
            marker.date = mapMarker.date
            repository.insert(marker, key: marker.objectID)
        }
    }
    
    private func convertMarkerObjectToMapMarker(marker: Marker) -> MapMarker {
        MapMarker(id: UUID(uuidString: marker.id ?? "") ?? UUID(),
                  position: CLLocationCoordinate2D(latitude: marker.latitude,
                                                   longitude: marker.longitude),
                  date: marker.date,
                  comments: marker.comments)
    }
}
