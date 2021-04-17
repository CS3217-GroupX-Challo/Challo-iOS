//
//  MapItineraryRepositoryInterface.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

protocol MapItineraryRepositoryInterface {
    func getAllItineraries() -> [ItineraryPersistenceObject]
    func saveItineraries(itineraryObjects: [ItineraryPersistenceObject])
}
