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
    let convertor = MapModelConvertor()
    
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
        let mapItineraries = emptyRepository.getAllItineraries()
        XCTAssertTrue(mapItineraries.isEmpty, "Should be empty")
    }
    
    func testGetAllMapItineraries_filledRepository_returnsArrayOfOne() {
        let mapItineraries = filledRepository.getAllItineraries()
        XCTAssertEqual(mapItineraries.count, 1, "Should have one element")
    }
    
    func testSaveMapItineraries_emptyRepoEmptyItineraries_nothingSaved() {
        emptyRepository.saveItineraries(itineraryObjects: [])
        XCTAssertTrue(emptyRepository.getAllItineraries().isEmpty, "should be empty")
    }
    
    func testSaveMapItineraries_emptyRepoOneItineraries_nothingSaved() {
        let object = convertor.convertMapItineraryToItineraryPersistenceObject(mapIitnerary:
                                                                                mockItineraryRepo.mapItinerary)
        emptyRepository.saveItineraries(itineraryObjects: [object])
        XCTAssertTrue(emptyRepository.getAllItineraries().isEmpty, "should be empty")
    }
    
    func testSaveMapItineraries_filledRepoEmptyItineraries_nothingSaved() {
        filledRepository.saveItineraries(itineraryObjects: [])
        let mapItineraries = filledRepository.getAllItineraries()
        XCTAssertEqual(mapItineraries.count, 1, "Should have one element")
    }
    
    func testSaveMapItineraries_filledRepoOneItineraries_nothingSaved() {
        let object = convertor.convertMapItineraryToItineraryPersistenceObject(mapIitnerary:
                                                                                mockItineraryRepo.mapItinerary)
        emptyRepository.saveItineraries(itineraryObjects: [object])
        let mapItineraries = filledRepository.getAllItineraries()
        XCTAssertEqual(mapItineraries.count, 1, "Should have one element")
    }
    
    func testConvertItineraryObjectToMapItinerary_returnsCorrectMapItinerary() {
        let mapItinerary = MapItineraryRepository
            .convertItineraryObjectToMapItinerary(itinerary: mockItineraryRepo.itinerary)
        XCTAssertEqual(mapItinerary, mockItineraryRepo.mapItinerary, "Should be same")
    }
}
