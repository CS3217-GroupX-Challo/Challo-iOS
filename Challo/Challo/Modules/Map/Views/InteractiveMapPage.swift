//
//  InteractiveMapPage.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI
import GoogleMaps

struct InteractiveMapPage: View {
    @ObservedObject var presenter: MapPresenter
    
    var body: some View {
        GoogleMapsView()
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                let markers = presenter.interactor.mapStore.getAllMapMarkers()
                let routes = presenter.interactor.mapStore.getAllMapRoutes()
                let mapItinerary = MapItinerary(id: UUID(), routes: routes, markers: markers,
                                                title: "Testing", createdAt: Date(), lastModified: Date())
                presenter.interactor.mapStore.saveMapItineraries(mapItineraries: [mapItinerary])
                print(presenter.interactor.mapStore.getAllMapItineraries())
            }
    }
}
