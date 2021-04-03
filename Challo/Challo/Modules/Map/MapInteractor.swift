//
//  MapInteractor.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

class MapInteractor: InteractorProtocol {
    var presenter: MapPresenter!
    var mapStore: MapStore
    var placesAPI: PlacesAPIProtocol
    
    init(mapStore: MapStore, placesAPI: PlacesAPIProtocol) {
        self.mapStore = mapStore
        self.placesAPI = placesAPI
    }
    
    func getPlaces(with name: String) {
        placesAPI.getPlaces(with: name) { [weak self] places in
            guard let self = self else {
                return
            }
            
            self.presenter.foundPlaces = places
        }
    }
}
