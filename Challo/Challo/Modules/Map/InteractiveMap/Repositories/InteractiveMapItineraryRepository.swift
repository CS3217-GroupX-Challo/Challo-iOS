//
//  ItineraryRepository.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import Foundation

class InteractiveMapItineraryRepository: Repository<UUID, MapItinerary>,
                                         InteractiveMapItineraryRepositoryProtocol {
    func getAllItineraries() -> [MapItinerary] {
        getAll()
    }
}
