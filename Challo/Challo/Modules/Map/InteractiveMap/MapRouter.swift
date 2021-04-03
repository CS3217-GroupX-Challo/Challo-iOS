//
//  MapRouter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

class MapRouter: RouterProtocol {

    weak var presenter: MapPresenter!
    var placesAPI: PlacesAPIProtocol
    var mapStore: MapStore
    
    init(placesAPI: PlacesAPIProtocol, mapStore: MapStore) {
        self.placesAPI = placesAPI
        self.mapStore = mapStore
    }

    func getNewItineraryPage() -> AnyView {
        let emptyItineraryPage = MapItineraryModule(placesAPI: placesAPI, mapStore: mapStore)
        return emptyItineraryPage.assemble().view
    }

    func getItineraryPage(for itinerary: MapItinerary) -> AnyView {
        let itineraryPage = MapItineraryModule(placesAPI: placesAPI, mapStore: mapStore, mapItinerary: itinerary)
        return itineraryPage.assemble().view
    }
}
