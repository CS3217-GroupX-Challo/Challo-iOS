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

    func getAllMapMarkers() -> [MapMarker] {
        allMarkers
    }

    func saveMapMarkers(mapMarkers: [MapMarker]) {
        mapMarkers.forEach {
            allMarkers.append($0)
        }
    }
}
