//
//  TrailBookingOptions.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailBookingOptions: View {

    @ObservedObject var presenter: TrailBookingPresenter
    @State private var pricePerPax = 25.5
    @State private var selectedPax = 0
    @State private var paxRange = [1, 2, 3, 4, 5]
    @State private var selectedDate = Date()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Price per guest: \(presenter.pricePerPaxString)")
                .font(.title3)
            Form {
                TrailPaxSelection(selectedPax: $presenter.selectedPax,
                                  paxRange: $presenter.paxRange)
                TrailDateSelection(selectedDate: $presenter.selectedDate)
            }
            Text("Total cost: \(presenter.totalPriceString)")
                .font(.title3)
        }
        .padding()
    }
}

struct TrailBookingOptions_Previews: PreviewProvider {
    static var previews: some View {
        TrailBookingOptions(presenter: TrailBookingPresenter())
    }
}
