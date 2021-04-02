//
//  MapItineraryInteractor.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import Combine
import MapKit

class MapItineraryInteractor: InteractorProtocol, ObservableObject {
    var presenter: MapItineraryPresenter!
    
    @Published var mapMarkers: [MapMarker]
    @Published var mapRoutes: [MapRoute]
    
    init(mapMarkers: [MapMarker], mapRoutes: [MapRoute]) {
        self.mapMarkers = mapMarkers
        self.mapRoutes = mapRoutes
    }
    
    convenience init() {
        self.init(mapMarkers: [], mapRoutes: [])
    }
    
    func createAndStoreDefaultMapMarker(position: CLLocationCoordinate2D) {
        let mapMarker = MapMarker(id: UUID(),
                                  position: position,
                                  date: nil,
                                  comments: nil)
        mapMarkers.append(mapMarker)
    }
}
