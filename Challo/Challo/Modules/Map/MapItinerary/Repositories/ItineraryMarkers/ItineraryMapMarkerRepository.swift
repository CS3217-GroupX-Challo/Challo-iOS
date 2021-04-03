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
        return repository.values.compactMap({ $0 })
    }
    
    func getByKey(_ key: CLLocationCoordinate2D) -> MapMarker? {
        return repository[key]
    }
    
    func insert(_ entity: MapMarker, key: CLLocationCoordinate2D?) -> CLLocationCoordinate2D? {
        guard let coordinates = key,
              !(repository.index(forKey: coordinates) != nil) else {
            return nil
        }
        
        repository[coordinates] = entity
        return coordinates
    }
    
    func deleteByKey(_ key: CLLocationCoordinate2D) -> MapMarker? {
        return repository.removeValue(forKey: key)
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
