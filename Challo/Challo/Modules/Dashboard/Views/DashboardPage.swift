//
//  DashboardPage.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct DashboardPage: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Header(title: "Challo Bernie",
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
                    
                    BookingCardListingsView(
                        width: geometry.size.width * 0.6,
                        bookings: [])
                    
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct DashboardPage_Previews: PreviewProvider {
    static var previews: some View {
        DashboardPage()
    }
}
