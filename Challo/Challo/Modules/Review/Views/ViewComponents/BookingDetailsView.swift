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
    }

    var body: some View {
        VStack(alignment: .leading) {
            Image("avatar-image")
                .resizable()
                .frame(width: width,
                       height: height * 0.8)
            // TODO: insert TrailGuideSelectionCard here once presenter is hooked up
            HStack(alignment: .top) {
                makeDetail(image: "leaf",
                           label: "Ramgargh River Trail")
                Spacer()
                makeDetail(image: "calendar",
                           label: CustomDateFormatter.displayFriendlyDate(Date()))
            }
        }
        .padding()
        .frame(width: width,
               height: height,
               alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

struct BookingDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookingDetailsView(width: 500, height: 500, booking: nil)
    }
}
