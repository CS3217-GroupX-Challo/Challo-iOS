//
//  ItineraryListingView.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct ItineraryListingView: View {

    @ObservedObject var presenter: MapPresenter

    var body: some View {
        if presenter.itineraries.isEmpty {
            Text("You have not created any itineraries yet.")
                .padding()
                .foregroundColor(.themeSecondary)
        } else {
            List(presenter.itineraries, id: \.id) { itinerary in
                NavigationLink(destination: presenter.getItineraryPage(for: itinerary)) {
                    ItineraryListingCard(itinerary: itinerary)
                }
            }
        }
    }
}
