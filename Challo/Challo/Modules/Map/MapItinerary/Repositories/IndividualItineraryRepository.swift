//
//  IndividualItineraryRepository.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import Foundation
import MapKit

class IndividualItineraryRepository {
    let mapMarkerRepository: ItineraryMapMarkerRepositoryProtocol
    let mapRoutesRepository: ItineraryMapRoutesRepositoryProtocol
    
    init(mapMarkerRepository: ItineraryMapMarkerRepositoryProtocol,
         mapRoutesRepository: ItineraryMapRoutesRepositoryProtocol) {
        self.mapMarkerRepository = mapMarkerRepository
        self.mapRoutesRepository = mapRoutesRepository
    }
    
    convenience init(mapMarkers: [MapMarker], mapRoutes: [MapRoute]) {
        var mapMarkersDict = [CLLocationCoordinate2D: MapMarker]()
        for mapMarker in mapMarkers {
            mapMarkersDict[mapMarker.position] = mapMarker
        }
        
        var mapRoutesDict = [UUID: MapRoute]()
        for mapRoute in mapRoutes {
            mapRoutesDict[mapRoute.id] = mapRoute
        }
        
        let mapMarkerRepository = ItineraryMapMarkerRepository(mapMarkersDict)
        let mapRoutesRepository = ItineraryMapRoutesRepository(mapRoutesDict)
        self.init(mapMarkerRepository: mapMarkerRepository,
                  mapRoutesRepository: mapRoutesRepository)
    }
}

// MARK: - MapMarker repository
extension IndividualItineraryRepository {
    func createAndStoreDefaultMapMarker(at position: CLLocationCoordinate2D) {
        mapMarkerRepository.createAndStoreDefaultMapMarker(at: position)
    }
    
    func addMapMarker(mapMarker: MapMarker) {
        mapMarkerRepository.addMapMarker(mapMarker: mapMarker)
    }
    
    func getMapMarker(at position: CLLocationCoordinate2D) -> MapMarker? {
        mapMarkerRepository.getMapMarker(at: position)
    }
    
    func deleteMapMarker(at position: CLLocationCoordinate2D) {
        mapMarkerRepository.deleteMapMarker(at: <#T##CLLocationCoordinate2D#>)
    }
}

// MARK: - MapRoute repository
extension IndividualItineraryRepository {
    func addRoute(route: MapRoute) {
        mapRoutesRepository.addRoute(route: route)
    }
    
    func getRoutes() -> [MapRoute] {
        mapRoutesRepository.getRoutes()
    }
}
