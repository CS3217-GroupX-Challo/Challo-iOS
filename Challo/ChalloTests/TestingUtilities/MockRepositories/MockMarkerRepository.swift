//
//  MockMarkerRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import MapKit
import Foundation

class MockMarkerRepository: MapMarkerRepositoryInterface {

    static func createEmptyRepo() -> MapMarkerRepositoryInterface {
        let repo = MockMarkerRepository()
        repo.allMarkers = []
        return repo
    }

    var allMarkers = [MapTestConstants.markerOne, MapTestConstants.markerTwo, MapTestConstants.markerThree]

    func getAllMarkers() -> [MarkerPersistenceObject] {
        allMarkers.map { marker in
            let convertor = MapModelConvertor()
            return convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker: marker)
        }
    }

    func saveMarkers(markerObjects: [MarkerPersistenceObject]) {
    }
}
