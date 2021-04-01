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
        GoogleMapsView(locationManager: presenter.locationManager,
                       mapDelegate: presenter)
            .edgesIgnoringSafeArea(.all)
    }
}
