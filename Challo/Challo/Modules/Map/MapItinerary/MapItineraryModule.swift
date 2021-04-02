//
//  MapItineraryModule.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import SwiftUI

final class MapItineraryModule: ViperModuleProtocol {
    let placesAPI: PlacesAPI
    let mapStore: MapStore
    
    init(placesAPI: PlacesAPI, mapStore: MapStore) {
        self.placesAPI = placesAPI
        self.mapStore = mapStore
    }
    
    func assemble() -> (view: AnyView, presenter: MapItineraryPresenter) {
        let interactor = MapItineraryInteractor()
        let router = MapItineraryRouter()
        let presenter = MapItineraryPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        
        return (AnyView(EmptyView()), presenter)
    }
}
