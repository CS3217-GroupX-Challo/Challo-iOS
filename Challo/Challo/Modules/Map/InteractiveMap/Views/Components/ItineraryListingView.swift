//
//  ItineraryListingView.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct ItineraryListingView: View {

    @Binding var itineraries: [MapItinerary]

    var body: some View {
        if itineraries.isEmpty {
            Text("You have not created any itineraries yet.")
                .padding()
                .foregroundColor(.themeSecondary)
        } else {
            List(itineraries, id: \.id) { itinerary in
                ItineraryListingCard(itinerary: itinerary)
            }
        }
    }
}
