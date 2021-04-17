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
    
    func getAllItineraries() -> [ItineraryPersistenceObject] {
        allItineraries.map { itinerary in
            let convertor = MapModelConvertor()
            return convertor
                .convertMapItineraryToItineraryPersistenceObject(mapIitnerary: itinerary)
        }
    }
    
    func saveItineraries(itineraryObjects: [ItineraryPersistenceObject]) {
    }
}
