//
//  MapMarkerRepositoryInterface.swift
//  Challo
//
//  Created by Kester Ng on 30/3/21.
//

import Foundation

protocol MapMarkerRepositoryInterface {
    func getAllMarkers() -> [MarkerPersistenceObject]
    func saveMarkers(markerObjects: [MarkerPersistenceObject])
    
    // TODO add other functions if needed
}
