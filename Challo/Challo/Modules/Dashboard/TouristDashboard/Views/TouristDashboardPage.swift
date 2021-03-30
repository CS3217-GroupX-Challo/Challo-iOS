//
//  DashboardPage.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct TouristDashboardPage: View {
    
    @ObservedObject var presenter: TouristDashboardPresenter

    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Header(title: presenter.name,
                           subtitle: "Ready to begin your journey with us?",
                           image: Image.mountainBackground)
                        .frame(width: geometry.size.width,
                               height: geometry.size.height * 0.15,
                               alignment: .center)

                    Image("avatar-image")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(height: geometry.size.height * 0.10)
                        .padding()

                    Text("Upcoming trips")
                        .font(.title2)
                        .bold()
                        .padding(.leading, 40)
                    
                    if presenter.isLoading {
                        VStack {
                            Loading(isAnimating: .constant(true), style: .large)
                        }
                    } else {
                        BookingCardListingsView(
                            width: geometry.size.width * 0.6,
                            bookings: $presenter.bookings)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            presenter.populateBookings()
        }
    }
}
