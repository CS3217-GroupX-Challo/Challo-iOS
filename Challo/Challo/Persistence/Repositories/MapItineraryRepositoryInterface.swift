//
//  MapItineraryRepositoryInterface.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

protocol MapItineraryRepositoryInterface {
    func getAllMapItineraries() -> [MapItinerary]
    func saveMapItineraries(mapItineraries: [MapItinerary])
}
