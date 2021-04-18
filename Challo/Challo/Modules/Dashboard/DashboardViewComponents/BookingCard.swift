//
//  TripCard.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct BookingCard<ChatView: View, ActionView: View>: View {

    @EnvironmentObject var presenter: TouristDashboardPresenter

    var booking: Booking
    var width: CGFloat
    var chatPartner: User

    var chatView: ChatView
    var actionIcons: ActionView

    init(booking: Booking,
         width: CGFloat,
         chatPartner: User,
         chatView: ChatView,
         @ViewBuilder actionIcons: () -> ActionView) {
        self.booking = booking
        self.width = width
        self.chatPartner = chatPartner
        self.chatView = chatView
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
                    NavigationLink(destination: chatView.environmentObject(presenter)) {
                        Image(systemName: "ellipsis.bubble.fill")
                            .foregroundColor(Color.pink)
                            .brightness(-0.05)
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
                makeDetail(image: "person.crop.circle", label: chatPartner.name ?? "")
                makeDetail(image: "dollarsign.square", customLabel: AnyView(
                    Text("\(Int(booking.fee))").bold() + Text(" Rp / pax")
                ))
            }.padding()
        }.padding()
    }
}
