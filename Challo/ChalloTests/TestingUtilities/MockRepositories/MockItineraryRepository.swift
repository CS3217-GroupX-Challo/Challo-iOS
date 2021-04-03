//
//  MockItineraryRepository.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 3/4/21.
//

@testable import Challo
import Foundation

class MockItineraryRepository: MapItineraryRepositoryInterface {
    
    static func createEmptyRepo() -> MapItineraryRepositoryInterface {
        let repo = MockItineraryRepository()
        repo.allItineraries = []
        return repo
    }

    var allItineraries = [MapTestConstants.itineraryOne, MapTestConstants.itineraryTwo]
    
    func getAllMapItineraries() -> [MapItinerary] {
        allItineraries
    }
    
    func saveMapItineraries(mapItineraries: [MapItinerary]) {
        mapItineraries.forEach {
            allItineraries.append($0)
        }
    }
}
