//
//  PastBookingCard.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

struct PastBookingCard: View {

    @EnvironmentObject var presenter: TouristDashboardPresenter

    var booking: Booking
    var width: CGFloat

    func makeDetail(image: String, label: String? = nil, customLabel: AnyView? = nil) -> some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 20)
            if let unwrappedLabel = label {
                Text(unwrappedLabel)
                    .font(.subheadline)
                    .foregroundColor(.themeAccent)
                    .lineLimit(1)
            }
            customLabel
            Spacer()
        }
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                Image.mountainBackground
                    .resizable()
                    .scaledToFill()
                    .frame(width: width)
                    .cornerRadius(10)
                VStack(spacing: 0) {
                    NavigationLink(destination: ContactGuidePage(guide: booking.guide).environmentObject(presenter)) {
                        Image(systemName: "ellipsis.bubble.fill")
                            .foregroundColor(Color.black.opacity(0.8))
                            .padding(10)
                    }
                    
                    NavigationLink(destination: presenter.getReviewPage(for: booking)) {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .foregroundColor(Color.black.opacity(0.8))
                            .padding(10)
                    }
                }

            }
            VStack(alignment: .leading) {
                HStack {
                    StarRatingsView(rating: booking.trail.rating, numOfReviews: booking.trail.numOfReviews)
                    Spacer()
                }
                makeDetail(image: "leaf", label: booking.trail.title)
                makeDetail(image: "calendar", label: CustomDateFormatter.displayFriendlyDate(booking.date))
                makeDetail(image: "person.crop.circle", label: booking.guide.name ?? "")
                makeDetail(image: "dollarsign.square", customLabel: AnyView(
                    HStack(spacing: 0) {
                        Text("\(Int(booking.fee))").bold()
                        Text(" / pax")
                    }
                ))
            }.padding()
        }.padding()
        
    }
}
