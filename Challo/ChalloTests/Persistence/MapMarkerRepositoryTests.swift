//
//  MapMarkerRepositoryTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 4/4/21.
//

import CoreData
import Foundation
import XCTest

@testable import Challo

class MapMarkerRepositoryTests: XCTestCase {
    typealias MapMarkerRepo = MockMapMarkerCoreDataRepository
    
    var emptyRepository: MapMarkerRepository {
        MapMarkerRepository(data: [NSManagedObjectID: MapMarker](),
                            repository:
                                MockMapMarkerCoreDataRepository(managedObjectContext:
                                                                    CoreDataContainer.managedObjectContext))
    }
    
    var filledRepository: MapMarkerRepository {
        let mockRepo = MockMapMarkerCoreDataRepository(managedObjectContext:
                                                        CoreDataContainer.managedObjectContext)
        mockRepo.data[MapMarkerRepo.marker1.objectID] = MapMarkerRepo.marker1
        return MapMarkerRepository(data: [NSManagedObjectID: MapMarker](),
                                   repository: mockRepo)
    }
    
    func testGetAllMapMarkers_mockEmpty_returnEmptyArray() {
        let mapMarkers = emptyRepository.getAllMapMarkers()
        XCTAssertEqual(mapMarkers.count, 0, "Should have 0")
    }
    
    func testGetAllMapMarkers_mockContainsTwoMapMarkers_returnExactTwoMapMarkers() {
        let mapMarkers = filledRepository.getAllMapMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Should have 1")
        testEqual(mapMarker: mapMarkers[0], marker: MapMarkerRepo.marker1)
    }
    
    func testSaveMapMarkers_withEmptyRepoEmptyArray_nothingSaved() {
        emptyRepository.saveMapMarkers(mapMarkers: [])
        XCTAssertEqual(emptyRepository.getAllMapMarkers().count, 0, "Should be empty")
    }
    
    func testSaveMapMarkers_withEmptyRepoArrayOfOne_nothingSaved() {
        emptyRepository.saveMapMarkers(mapMarkers: [MapMarkerRepo.mapMarker1])
        let mapMarkers = emptyRepository.getAllMapMarkers()
        XCTAssertEqual(mapMarkers.count, 0, "Should be empty")
    }
    
    func testSaveMapMarkers_withFilledRepoArrayOfTwo_nothingSaved() {
        filledRepository.saveMapMarkers(mapMarkers: [MapMarkerRepo.mapMarker1, MapMarkerRepo.mapMarker2])
        let mapMarkers = filledRepository.getAllMapMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Only one element")
    }
    
    func testSaveMapMarkers_withFilledRepoEmptyArray_nothingSaved() {
        filledRepository.saveMapMarkers(mapMarkers: [])
        XCTAssertEqual(filledRepository.getAllMapMarkers().count, 1, "Only one element")
    }
    
    func testSaveMapMarkers_withFilledRepoArrayOfOne_nothingSaved() {
        filledRepository.saveMapMarkers(mapMarkers: [MapMarkerRepo.mapMarker1])
        let mapMarkers = filledRepository.getAllMapMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Only one element")
    }
    
    func testSaveMapMarkers_withEmptyRepoArrayOfTwo_nothingSaved() {
        filledRepository.saveMapMarkers(mapMarkers: [MapMarkerRepo.mapMarker1, MapMarkerRepo.mapMarker2])
        let mapMarkers = filledRepository.getAllMapMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Only one element")
    }
    
    func testConvertMarkerObjectToMapMarker_withMockMarkerOne_correctMapMarker() {
        let mapMarker = MapMarkerRepository
            .convertMarkerObjectToMapMarker(marker: MapMarkerRepo.marker1)
        XCTAssertEqual(mapMarker, MapMarkerRepo.mapMarker1)
    }
    
    private func testEqual(mapMarker: MapMarker, marker: Marker) {
        XCTAssertEqual(mapMarker.id.uuidString, marker.id, "Should be same")
        XCTAssertEqual(mapMarker.date, marker.date, "should be same")
        XCTAssertEqual(mapMarker.comments, marker.comments, "should be same")
        XCTAssertEqual(mapMarker.position.latitude, marker.latitude, "should be same")
        XCTAssertEqual(mapMarker.position.longitude, marker.longitude, "should be same")
    }
}
