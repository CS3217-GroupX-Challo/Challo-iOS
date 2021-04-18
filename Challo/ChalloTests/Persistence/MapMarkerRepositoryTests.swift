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
    let convertor = MapModelConvertor()
    
    var emptyRepository: MapMarkerRepository {
        MapMarkerRepository(data: [NSManagedObjectID: MarkerPersistenceObject](),
                            repository:
                                MockMapMarkerCoreDataRepository(managedObjectContext:
                                                                    CoreDataContainer.managedObjectContext))
    }
    
    var filledRepository: MapMarkerRepository {
        let mockRepo = MockMapMarkerCoreDataRepository(managedObjectContext:
                                                        CoreDataContainer.managedObjectContext)
        mockRepo.data[MapMarkerRepo.marker1.objectID] = MapMarkerRepo.marker1
        return MapMarkerRepository(data: [NSManagedObjectID: MarkerPersistenceObject](),
                                   repository: mockRepo)
    }
    
    func testGetAllMapMarkers_mockEmpty_returnEmptyArray() {
        let mapMarkers = emptyRepository.getAllMarkers()
        XCTAssertEqual(mapMarkers.count, 0, "Should have 0")
    }
    
    func testGetAllMapMarkers_mockContainsTwoMapMarkers_returnExactTwoMapMarkers() {
        let mapMarkers = filledRepository.getAllMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Should have 1")
    }
    
    func testSaveMapMarkers_withEmptyRepoEmptyArray_nothingSaved() {
        emptyRepository.saveMarkers(markerObjects: [])
        XCTAssertEqual(emptyRepository.getAllMarkers().count, 0, "Should be empty")
    }
    
    func testSaveMapMarkers_withEmptyRepoArrayOfOne_nothingSaved() {
        let object = convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker:
                                                                            MapMarkerRepo.mapMarker1)
        emptyRepository.saveMarkers(markerObjects: [object])
        let mapMarkers = emptyRepository.getAllMarkers()
        XCTAssertEqual(mapMarkers.count, 0, "Should be empty")
    }
    
    func testSaveMapMarkers_withFilledRepoArrayOfTwo_nothingSaved() {
        let object1 = convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker:
                                                                            MapMarkerRepo.mapMarker1)
        let object2 = convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker:
                                                                            MapMarkerRepo.mapMarker2)
        filledRepository.saveMarkers(markerObjects: [object1, object2])
        let mapMarkers = filledRepository.getAllMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Only one element")
    }
    
    func testSaveMapMarkers_withFilledRepoEmptyArray_nothingSaved() {
        filledRepository.saveMarkers(markerObjects: [])
        XCTAssertEqual(filledRepository.getAllMarkers().count, 1, "Only one element")
    }
    
    func testSaveMapMarkers_withFilledRepoArrayOfOne_nothingSaved() {
        let object = convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker:
                                                                            MapMarkerRepo.mapMarker1)
        filledRepository.saveMarkers(markerObjects: [object])
        let mapMarkers = filledRepository.getAllMarkers()
        XCTAssertEqual(mapMarkers.count, 1, "Only one element")
    }
    
    func testSaveMapMarkers_withEmptyRepoArrayOfTwo_nothingSaved() {
        let object1 = convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker:
                                                                            MapMarkerRepo.mapMarker1)
        let object2 = convertor.convertMapMarkerToMarkerPersistenceObject(mapMarker:
                                                                            MapMarkerRepo.mapMarker2)
        filledRepository.saveMarkers(markerObjects: [object1, object2])
        let mapMarkers = filledRepository.getAllMarkers()
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
