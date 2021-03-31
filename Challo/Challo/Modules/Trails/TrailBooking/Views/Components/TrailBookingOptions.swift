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
                                        selectedGuideId: $presenter.selectedGuideId,
                                        cardWidth: width / 3,
                                        cardHeight: width / 3)
            }
            HStack {
                Text("Total cost: \(presenter.totalPriceString)")
                    .font(.title3)
                Spacer()
                Button(action: presenter.makeBooking) {
                    Text("Confirm")
                        .bold()
                }
                .buttonStyle(BorderedButtonStyle(borderColor: .themeTertiary, foregroundColor: .themeForeground))
            }
        }
        .padding()
        .frame(width: width,
               height: height,
               alignment: .center)
    }
}
