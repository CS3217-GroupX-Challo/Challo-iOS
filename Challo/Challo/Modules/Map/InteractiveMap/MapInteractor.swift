//
//  MapInteractor.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import Foundation

class MapInteractor: InteractorProtocol {
    var presenter: MapPresenter!
    var mapStore: MapStore
    var placesAPI: PlacesAPIProtocol
    var itineraryRepository: InteractiveMapItineraryRepositoryProtocol
    
    init(mapStore: MapStore, placesAPI: PlacesAPIProtocol) {
        self.mapStore = mapStore
        self.placesAPI = placesAPI
        
        let mapItineraries = mapStore.getAllMapItineraries()
        var mapItinerariesDict = [UUID: MapItinerary]()
        for mapItinerary in mapItineraries {
            mapItinerariesDict[mapItinerary.id] = mapItinerary
        }
        self.itineraryRepository = InteractiveMapItineraryRepository(mapItinerariesDict)
    }
    
    func getPlaces(with name: String) {
        placesAPI.getPlaces(with: name) { [weak self] places in
            guard let self = self else {
                return
            }
            
            self.presenter.foundPlaces = places
        }
    }
    
    func getMapItineraries() -> [MapItinerary] {
        itineraryRepository.getAllItineraries()
    }
}
