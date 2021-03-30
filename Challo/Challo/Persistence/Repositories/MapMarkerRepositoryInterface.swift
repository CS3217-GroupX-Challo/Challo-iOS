//
//  MapMarkerRepositoryInterface.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import Foundation

protocol MapMarkerRepositoryInterface {
    func getAllMapMarkers() -> [MapMarker]
    func saveMapMarkers(mapMarkers: [MapMarker])
    
    // TODO add other functions if needed
}
