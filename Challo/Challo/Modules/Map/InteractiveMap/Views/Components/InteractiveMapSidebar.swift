//
//  InteractiveMapSidebar.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct InteractiveMapSidebar: View {
    
    @EnvironmentObject var presenter: MapPresenter

    var body: some View {
        VStack {
            VStack {
                NavigationLink(destination: presenter.getMapPage()) {
                    Text("Back to map")
                }

                NavigationLink(destination: presenter.getNewItineraryPage()) {
                    Text("Create new itinerary")
                }
            }.padding(20)

            ItineraryListingView(presenter: presenter)
                .navigationBarTitle(Text("Menu"), displayMode: .inline)
        }
        .onAppear {
            presenter.refreshItineraries()
        }
    }
}
