//
//  ItineraryMapMarkerRepositoryProtocol.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import MapKit

protocol ItineraryMapMarkerRepositoryProtocol {
    func createAndStoreDefaultMapMarker(at position: CLLocationCoordinate2D)
    func addMapMarker(mapMarker: MapMarker)
    func getMapMarker(at position: CLLocationCoordinate2D) -> MapMarker?
    func deleteMapMarker(at position: CLLocationCoordinate2D)
    func getAllMapMarkers() -> [MapMarker]
}
