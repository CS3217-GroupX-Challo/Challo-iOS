//
//  TripCard.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct BookingCard<Content: View>: View {

    @EnvironmentObject var presenter: TouristDashboardPresenter

    var booking: Booking
    var width: CGFloat
    var actionIcons: Content

    init(booking: Booking,
         width: CGFloat,
         @ViewBuilder actionIcons: () -> Content) {
        self.booking = booking
        self.width = width
        self.actionIcons = actionIcons()
    }
    
    var trailImage: String? {
        booking.trail.images.isEmpty ? nil : booking.trail.images[0]
    }

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
                ImageLoader(profileImg: trailImage, width: width, height: 200, defaultImage: "mountain-background")
                    .frame(width: width, height: 200)
                    .cornerRadius(10)
                VStack {
                    NavigationLink(destination: ContactGuidePage(guide: booking.guide).environmentObject(presenter)) {
                        Image(systemName: "ellipsis.bubble.fill")
                            .foregroundColor(Color.black.opacity(0.8))
                            .padding(10)
                    }
                    actionIcons
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
