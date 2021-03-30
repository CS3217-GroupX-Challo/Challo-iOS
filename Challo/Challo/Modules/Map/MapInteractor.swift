//
//  MapInteractor.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

class MapInteractor: InteractorProtocol {
    var presenter: MapPresenter!
    var mapStore = MapMarkerStore(repository: MapMarkerRepository())
}
