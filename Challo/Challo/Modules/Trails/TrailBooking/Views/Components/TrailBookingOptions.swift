//
//  TrailBookingOptions.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailBookingOptions: View {

    @ObservedObject var presenter: TrailBookingPresenter
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text("Price per guest: \(presenter.pricePerPaxString)")
                .font(.title3)
            Form {
                TrailPaxSelection(selectedPax: $presenter.selectedPax,
                                  paxRange: $presenter.paxRange)
                TrailDateSelection(selectedDate: $presenter.selectedDate)
                TrailGuideSelectionList(guides: $presenter.availableGuides,
                                        selectedIndex: $presenter.selectedGuideIdx,
                                        cardWidth: width / 3,
                                        cardHeight: width / 3)
            }
            Text("Total cost: \(presenter.totalPriceString)")
                .font(.title3)
        }
        .padding()
        .frame(width: width,
               height: height,
               alignment: .center)
    }
}
