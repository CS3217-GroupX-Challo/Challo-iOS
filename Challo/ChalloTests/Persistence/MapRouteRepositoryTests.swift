//
//  MapRouteRepositoryTests.swift
//  ChalloTests
//
//  Created by Kester Ng on 4/4/21.
//

import CoreData
import Foundation
import XCTest

@testable import Challo

class MapRouteRepositoryTests: XCTestCase {
    typealias mockRepo = MockMapRouteCoreDataRepository
    
    var emptyRepository: MapRouteRepository {
        MapRouteRepository(repository: mockRepo(managedObjectContext: CoreDataContainer.managedObjectContext),
                           mapMarkerRepository:
                            MockMapMarkerCoreDataRepository(managedObjectContext:
                                                                CoreDataContainer.managedObjectContext))
    }
    
    var filledRepository: MapRouteRepository {
        let mock = mockRepo(managedObjectContext: CoreDataContainer.managedObjectContext)
        mock.data.append(mockRepo.route1)
        let mapRouteRepo = MapRouteRepository(repository: mock,
                                              mapMarkerRepository:
                                               MockMapMarkerCoreDataRepository(managedObjectContext:
                                                                                   
                                                                                CoreDataContainer.managedObjectContext))
        return mapRouteRepo
    }
    
    func testGetAllRoutes_emptyRepository_returnsEmptyRoutes() {
        let mapRoutes = emptyRepository.getAllRoutes()
        XCTAssertTrue(mapRoutes.isEmpty, "Should be empty")
    }
    
    func testGetAllRoutes_filledRepository_returnsCorrectRoutes() {
        let mapRoutes = filledRepository.getAllRoutes()
        XCTAssertEqual(mapRoutes.count, 1, "Should have one")
        XCTAssertEqual(mapRoutes[0], mockRepo.mapRoute1, "Should be equal")
    }
    
    func testSaveMapRoutes_emptyRepositoryEmptyRoutes_nothingSaved() {
        emptyRepository.saveMapRoutes(mapRoutes: [])
        XCTAssertTrue(emptyRepository.getAllRoutes().isEmpty, "Should be empty")
    }
    
    func testSaveMapRoutes_emptyRepositoryOneRoute_nothingSaved() {
        emptyRepository.saveMapRoutes(mapRoutes: [mockRepo.mapRoute1])
        XCTAssertTrue(emptyRepository.getAllRoutes().isEmpty, "Should be empty")
    }
    
    func testSaveMapRoutes_filledRepositoryEmptyRoutes_nothingSaved() {
        filledRepository.saveMapRoutes(mapRoutes: [])
        XCTAssertEqual(filledRepository.getAllRoutes().count, 1, "Should contain one element")
    }
    
    func testSaveMapRoutes_filledRepositoryOneRoute_nothingSaved() {
        filledRepository.saveMapRoutes(mapRoutes: [mockRepo.mapRoute1])
        XCTAssertEqual(filledRepository.getAllRoutes().count, 1, "Should be empty")
    }
}
