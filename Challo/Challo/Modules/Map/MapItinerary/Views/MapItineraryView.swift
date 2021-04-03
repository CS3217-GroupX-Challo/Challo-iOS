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
                                       paddingTop: geometry.size.height / 19)
                    Button(action: { print("fuck") }, label: {
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                    })
                    Spacer()
                    if presenter.isSaveSelected {
                        ItinerarySaveModalView(presenter: presenter,
                                               width: geometry.size.width / 2,
                                               text: $presenter.title,
                                               isShowing: $presenter.isSaveSelected)
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $presenter.isEditing) {
                MarkerEditModal(presenter: presenter)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        .navigationBarTitle("Editing Itinerary", displayMode: .inline)
    }
}
