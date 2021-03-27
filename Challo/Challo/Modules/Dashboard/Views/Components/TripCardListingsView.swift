//
//  TripCardListingsView.swift
//  Challo
//
//  Created by Tan Le Yang on 27/3/21.
//

import SwiftUI

struct TripCardListingsView: View {

    var width: CGFloat
    var trips: [Trip]

    var body: some View {
        ScrollView(showsIndicators: false) {
            if trips.isEmpty {
                Text("You don't have any upcoming trips")
                    .foregroundColor(.themeForeground)
            }
            ForEach(trips.indices) { index in
                TripCard(trip: trips[index], width: width)
            }
        }
    }
}

struct TripCardListingsView_Previews: PreviewProvider {
    static var previews: some View {
        TripCardListingsView(width: 300,
                             trips: TripCard.trips)
    }
}
