//
//  BookingDetails.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct BookingDetailsView: View {

    var width: CGFloat
    var height: CGFloat
    var booking: Booking?

    func makeDetail(image: String, label: String) -> some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: width / 10)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .frame(maxWidth: width / 2, maxHeight: 50)
        }
        .frame(maxHeight: height * 0.2)
    }

    var body: some View {
        VStack(alignment: .leading) {
            // TODO: insert TrailGuideSelectionCard here once presenter is hooked up
            HStack {
                Image("avatar-image")
                    .resizable()
                    .frame(width: width * 0.5,
                           height: height)
                VStack {
                    makeDetail(image: "leaf",
                               label: "Ramgargh River Trail")
                    makeDetail(image: "calendar",
                               label: CustomDateFormatter.displayFriendlyDate(Date()))
                    makeDetail(image: "dollarsign.circle",
                               label: "3000Rp")
                }
                .padding()
            }
        }
        .padding()
        .frame(width: width,
               height: height,
               alignment: .center)
    }
}

struct BookingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailsView(width: 800, height: 500, booking: nil)
    }
}
