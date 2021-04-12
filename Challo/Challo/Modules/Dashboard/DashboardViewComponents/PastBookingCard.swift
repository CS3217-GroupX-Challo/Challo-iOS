//
//  PastBookingCard.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

struct PastBookingCard: View, CustomLabelMaker {

    @EnvironmentObject var presenter: TouristDashboardPresenter

    var booking: Booking
    var width: CGFloat
    
    var body: some View {
        Card {
            Image.mountainBackground
                .resizable()
                .scaledToFit()
                .frame(width: 300)
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
            HStack(alignment: .top) {
                makeDetail(image: "leaf",
                           label: booking.trail.title)
                makeDetail(image: "calendar",
                           label: CustomDateFormatter.displayFriendlyDate(booking.date))
                makeDetail(image: "person.crop.circle",
                           label: booking.guide.name ?? "")
            }
            HStack {
                NavigationLink(destination: ContactGuidePage(guide: booking.guide).environmentObject(presenter)) {
                    Text("Contact Guide").bold()
                }.buttonStyle(BorderedButtonStyle(borderColor: .themeTertiary, foregroundColor: .themeTertiary))
                
                NavigationLink(destination: presenter.getReviewPage(for: booking)) {
                    Text("Leave a Review").bold()
                }.buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeSecondary))
            }
            .padding()
        }.cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .background(Color.clear)
                .shadow(color: Color.gray, radius: 1, x: 1, y: 1)
                .shadow(color: Color.gray, radius: 3, x: 3, y: 4)
        )
        .frame(width: width,
               alignment: .center)
        .padding()
        
    }
}
