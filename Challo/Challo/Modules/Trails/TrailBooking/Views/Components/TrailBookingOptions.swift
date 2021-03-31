//
//  TrailBookingOptions.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailBookingOptions: View {

    @ObservedObject var presenter: TrailBookingPresenter

    var body: some View {
        VStack(alignment: .leading) {
            Text("Price per guest: \(presenter.pricePerPaxString)")
                .font(.title3)
            Form {
                TrailPaxSelection(selectedPax: $presenter.selectedPax,
                                  paxRange: $presenter.paxRange)
                TrailDateSelection(selectedDate: $presenter.selectedDate)
                TrailGuideSelectionList(guides: $presenter.availableGuides,
                                        selectedIndex: $presenter.selectedGuideIdx)
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
