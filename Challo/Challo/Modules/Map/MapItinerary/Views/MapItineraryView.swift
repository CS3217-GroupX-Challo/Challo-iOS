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
                    ItineraryEditorBar(presenter: presenter,
                                       paddingTop: geometry.size.height / 30)
                    Spacer()
                    if presenter.isSaveSelected {
                        ItinerarySaveModalView(presenter: presenter,
                                               width: geometry.size.width / 2,
                                               isShowing: $presenter.isSaveSelected)
                    }
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
}
