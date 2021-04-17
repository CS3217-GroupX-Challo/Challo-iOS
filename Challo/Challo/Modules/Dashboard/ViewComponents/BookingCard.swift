//
//  TripCard.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct BookingCard<ChatView: View>: View {

    @EnvironmentObject var presenter: TouristDashboardPresenter

    var booking: Booking
    var width: CGFloat
    var chatPartner: User

    var chatView: ChatView
    var contactMessage: String
    
    var body: some View {
        BookingCardLayout(width: width) {
            Card {
                Image.mountainBackground
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 20)
                HStack(alignment: .top) {
                    LabeledImage(imageName: "leaf",
                                 label: booking.trail.title,
                                 textWidth: width / 4)
                        .frame(width: width / 3)
                    LabeledImage(imageName: "calendar",
                                 label: CustomDateFormatter.displayFriendlyDate(booking.date),
                                 textWidth: width / 4)
                        .frame(width: width / 3)
                    LabeledImage(imageName: "person.crop.circle",
                                 label: chatPartner.name ?? "",
                                 textWidth: width / 4)
                        .frame(width: width / 3)
                }
                NavigationLink(destination: chatView.environmentObject(presenter)) {
                    Text(contactMessage).bold()
                }.buttonStyle(BorderedButtonStyle(borderColor: .themeTertiary, foregroundColor: .themeTertiary))
                .padding()
            }
        }
    }
}
