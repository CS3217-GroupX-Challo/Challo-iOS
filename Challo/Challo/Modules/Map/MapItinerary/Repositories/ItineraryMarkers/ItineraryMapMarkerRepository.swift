//
//  ItineraryMarkerRepository.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import Foundation
import MapKit

class ItineraryMapMarkerRepository: RepositoryProtocol {
    typealias Entity = MapMarker
    typealias Key = CLLocationCoordinate2D
    
    private var repository: [CLLocationCoordinate2D: MapMarker]
    
    init(_ initialRepository: [CLLocationCoordinate2D: MapMarker]? = nil) {
        repository = initialRepository ?? [CLLocationCoordinate2D: MapMarker]()
    }
    
    func getAll() -> [MapMarker] {
        repository.values.compactMap({ $0 })
    }
    
    func getByKey(_ key: CLLocationCoordinate2D) -> MapMarker? {
        repository[key]
    }
    
    @discardableResult
    func insert(_ entity: MapMarker, key: CLLocationCoordinate2D?) -> CLLocationCoordinate2D? {
        guard let coordinates = key,
              !(repository.index(forKey: coordinates) != nil) else {
            return nil
        }
        
        repository[coordinates] = entity
        return coordinates
    }
    
    @discardableResult
    func deleteByKey(_ key: CLLocationCoordinate2D) -> MapMarker? {
        repository.removeValue(forKey: key)
    }
    
    @discardableResult
    func updateByKey(entity: MapMarker, key: CLLocationCoordinate2D) -> MapMarker? {
        repository[key] = entity
        return entity
    }
    
    @discardableResult
    func upsert(entity: MapMarker, key: CLLocationCoordinate2D) -> MapMarker {
        repository[key] = entity
        return entity
    }
}

extension ItineraryMapMarkerRepository: ItineraryMapMarkerRepositoryProtocol {
    func createAndStoreDefaultMapMarker(at position: CLLocationCoordinate2D) {
        let mapMarker = MapMarker(id: UUID(),
                                  position: position,
                                  date: nil,
                                  comments: nil)
        insert(mapMarker, key: mapMarker.position)
    }
    
    func addMapMarker(mapMarker: MapMarker) {
        insert(mapMarker, key: mapMarker.position)
    }
    
    func getMapMarker(at position: CLLocationCoordinate2D) -> MapMarker? {
        getByKey(position)
    }
    
    func deleteMapMarker(at position: CLLocationCoordinate2D) {
        deleteByKey(position)
    }
    
    func getAllMapMarkers() -> [MapMarker] {
        getAll()
    }
}
