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
        GeometryReader { geometry in
            ZStack {
                presenter.googleMapsView
                VStack {
                    ItineraryEditorBar(paddingTop: geometry.size.height / 30)
                    Spacer()
                    if presenter.isSaveSelected {
                        ItinerarySaveModalView(width: geometry.size.width / 2)
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $presenter.isEditing) {
                MarkerEditModal(presenter: presenter)
            }
        }
        .environmentObject(presenter)
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        .navigationBarTitle("Editing Itinerary", displayMode: .inline)
    }
}
