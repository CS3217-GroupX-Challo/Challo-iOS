//
//  MapModule.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

final class MapModule: ViperModuleProtocol {
    func assemble() -> (view: AnyView, presenter: MapPresenter) {
        let mapStore = MapStore(mapMarkerRepository: MapMarkerRepository(),
                                mapRouteRepository: MapRouteRepository(),
                                mapItineraryRepository: MapItineraryRepository())
        
        // TODO make url for alamofiremanager injected in
        let networkManager = APINetwork.getNetworkManager()
        if let alamofireManager = networkManager as? AlamofireManager {
            alamofireManager.apiPath = ProcessInfo.processInfo.environment["google_places_path"]
        }
        
        let placesAPI = PlacesAPI(parser: PlacesAPIParser(), networkManager: networkManager)
        
        let interactor = MapInteractor(mapStore: mapStore, placesAPI: placesAPI)
        let router = MapRouter()
        let presenter = MapPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(InteractiveMapPage(presenter: presenter)),
                presenter: presenter)
    }
}
