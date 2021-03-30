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
                /*
                let mapMarker = MapMarker(id: UUID(),
                                          position: CLLocationCoordinate2D(latitude: 20, longitude: 40),
                                          date: Date(), comments: "Hello!")
                presenter.interactor.mapStore.saveMapMarkers(mapMarkers: [mapMarker])*/
                print(presenter.interactor.mapStore.getAllMapMarkers())
            }
    }
}
