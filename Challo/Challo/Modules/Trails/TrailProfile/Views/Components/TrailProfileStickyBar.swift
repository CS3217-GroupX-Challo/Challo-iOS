//
//  TrailProfileStickyBar.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

struct TrailProfileStickyBar: View {
    @EnvironmentObject var presenter: TrailProfilePresenter

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            UnwrapView(presenter.currentEntity) { trail in
                Text("\(trail.lowestFee)").bold() + Text(" Rp / pax")
                StarRatingsView(rating: trail.rating, numOfReviews: trail.numOfReviews, maxHeight: 12)
            }
        }
        Spacer()
        NavigationLink(destination: presenter.trailBookingPage) {
            Text("Book This Trail")
                .padding()
                .foregroundColor(.white)
                .background(Color.themeTertiary)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.themeTertiary, lineWidth: 1))
                .padding([.top, .bottom], 10)
                .font(Font.system(size: 15, weight: .semibold))
        }
        .disabled(!presenter.userCanMakeBooking)
        .onTapGesture {
            presenter.onTapBookCTAButton()
        }
    }
}
