//
//  MapItineraryRepositoryTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 4/4/21.
//

import CoreData
import Foundation
import XCTest

@testable import Challo

class MapItineraryRepositoryTests: XCTestCase {
    typealias mockItineraryRepo = MockMapItineraryCoreDataRepository
    typealias mockMarkerRepo = MockMapMarkerCoreDataRepository
    typealias mockRouteRepo = MockMapRouteCoreDataRepository
    
    var managedContext = CoreDataContainer.managedObjectContext
    
    var emptyRepository: MapItineraryRepository {
        MapItineraryRepository(repository: mockItineraryRepo(managedObjectContext: managedContext),
                               mapMarkerRepository: mockMarkerRepo(managedObjectContext: managedContext),
                               mapRouteRepository: mockRouteRepo(managedObjectContext: managedContext))
    }
    
    var filledRepository: MapItineraryRepository {
        let mockRepo = mockItineraryRepo(managedObjectContext: managedContext)
        mockRepo.data.append(mockItineraryRepo.itinerary)
        return MapItineraryRepository(repository: mockRepo,
                                      mapMarkerRepository: mockMarkerRepo(managedObjectContext: managedContext),
                                      mapRouteRepository: mockRouteRepo(managedObjectContext: managedContext))
    }
    
    func testGetAllMapItineraries_emptyRepository_returnsEmptyArray() {
        let mapItineraries = emptyRepository.getAllMapItineraries()
        XCTAssertTrue(mapItineraries.isEmpty, "Should be empty")
    }
    
    func testGetAllMapItineraries_filledRepository_returnsArrayOfOne() {
        let mapItineraries = filledRepository.getAllMapItineraries()
        XCTAssertEqual(mapItineraries.count, 1, "Should have one element")
        XCTAssertEqual(mapItineraries[0], mockItineraryRepo.mapItinerary, "Should be equal")
    }
    
    func testSaveMapItineraries_emptyRepoEmptyItineraries_nothingSaved() {
        emptyRepository.saveMapItineraries(mapItineraries: [])
        XCTAssertTrue(emptyRepository.getAllMapItineraries().isEmpty, "should be empty")
    }
    
    func testSaveMapItineraries_emptyRepoOneItineraries_nothingSaved() {
        emptyRepository.saveMapItineraries(mapItineraries: [mockItineraryRepo.mapItinerary])
        XCTAssertTrue(emptyRepository.getAllMapItineraries().isEmpty, "should be empty")
    }
    
    func testSaveMapItineraries_filledRepoEmptyItineraries_nothingSaved() {
        filledRepository.saveMapItineraries(mapItineraries: [])
        let mapItineraries = filledRepository.getAllMapItineraries()
        XCTAssertEqual(mapItineraries.count, 1, "Should have one element")
        XCTAssertEqual(mapItineraries[0], mockItineraryRepo.mapItinerary, "Should be equal")
    }
    
    func testSaveMapItineraries_filledRepoOneItineraries_nothingSaved() {
        emptyRepository.saveMapItineraries(mapItineraries: [mockItineraryRepo.mapItinerary])
        let mapItineraries = filledRepository.getAllMapItineraries()
        XCTAssertEqual(mapItineraries.count, 1, "Should have one element")
        XCTAssertEqual(mapItineraries[0], mockItineraryRepo.mapItinerary, "Should be equal")
    }
    
    func testConvertItineraryObjectToMapItinerary_returnsCorrectMapItinerary() {
        let mapItinerary = MapItineraryRepository
            .convertItineraryObjectToMapItinerary(itinerary: mockItineraryRepo.itinerary)
        XCTAssertEqual(mapItinerary, mockItineraryRepo.mapItinerary, "Should be same")
    }
}
