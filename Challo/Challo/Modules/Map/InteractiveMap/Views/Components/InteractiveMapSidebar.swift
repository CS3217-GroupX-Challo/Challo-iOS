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
        ItineraryListingView(itineraries: $presenter.itineraries)
            .navigationBarTitle(Text("Itineraries"), displayMode: .inline)
    }
}
