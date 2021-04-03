//
//  MapItineraryModule.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import SwiftUI

final class MapItineraryModule: ViperModuleProtocol {
    let placesAPI: PlacesAPIProtocol
    let mapStore: MapStore
    let mapItinerary: MapItinerary
    
    init(placesAPI: PlacesAPIProtocol, mapStore: MapStore, mapItinerary: MapItinerary) {
        self.placesAPI = placesAPI
        self.mapStore = mapStore
        self.mapItinerary = mapItinerary
    }
    
    convenience init(placesAPI: PlacesAPIProtocol, mapStore: MapStore) {
        let mapItinerary = MapItinerary(id: UUID(),
                                        routes: [],
                                        markers: [],
                                        title: "",
                                        createdAt: Date(),
                                        lastModified: Date())
        self.init(placesAPI: placesAPI, mapStore: mapStore, mapItinerary: mapItinerary)
    }
    
    func assemble() -> (view: AnyView, presenter: MapItineraryPresenter) {
        let interactor = MapItineraryInteractor(mapStore: mapStore)
        let router = MapItineraryRouter()
        let presenter = MapItineraryPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.initializeBindings()
        
        return (AnyView(MapItineraryView(presenter: presenter)), presenter)
    }
}
