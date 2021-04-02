//
//  MapItineraryView.swift
//  Challo
//
//  Created by Kester Ng on 2/4/21.
//

import SwiftUI
import GoogleMaps

struct MapItineraryView: View {
    @ObservedObject var presenter: MapItineraryPresenter
    
    var body: some View {
        presenter.googleMapsView
    }
}
