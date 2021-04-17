//
//  MapModule.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

final class MapModule: ViperModuleProtocol {
    let placesAPI: PlacesAPIProtocol
    
    init(placesAPI: PlacesAPIProtocol) {
        self.placesAPI = placesAPI
    }
        
    func assemble() -> (view: AnyView, presenter: MapPresenter) {
        let mapStore = MapStore(mapMarkerRepository: MapMarkerRepository(),
                                mapRouteRepository: MapRouteRepository(),
                                mapItineraryRepository: MapItineraryRepository(),
                                convertor: MapModelConvertor())
        let interactor = MapInteractor(mapStore: mapStore, placesAPI: placesAPI)
        let router = MapRouter(placesAPI: placesAPI, mapStore: mapStore)
        let presenter = MapPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.itineraries = interactor.getMapItineraries()
        let view = AnyView(InteractiveMapPage(presenter: presenter))
        router.mapView = view
        return (view: view,
                presenter: presenter)
    }
}
