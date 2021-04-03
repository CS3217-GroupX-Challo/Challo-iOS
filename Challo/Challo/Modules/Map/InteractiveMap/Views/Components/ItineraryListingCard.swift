//
//  ItineraryCard.swift
//  Challo
//
//  Created by Tan Le Yang on 3/4/21.
//

import SwiftUI

struct ItineraryListingCard: View {
    
    var itinerary: MapItinerary

    private var itineraryDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YY HH:mm"
        return dateFormatter.string(from: itinerary.lastModified)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(itinerary.title)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(itinerary.markers.count)", systemImage: "mappin")
                Spacer()
                Label("\(itineraryDateString)", systemImage: "clock")
                    .padding(.trailing, 20)
            }
        }
        .padding()
        .foregroundColor(Color.themeSecondary)
    }
}

struct ItineraryCard_Previews: PreviewProvider {
    static var test = MapItinerary(id: UUID(),
                                   routes: [],
                                   markers: [],
                                   title: "Dream graduation trip <3",
                                   createdAt: Date(),
                                   lastModified: Date())
    static var previews: some View {
        ItineraryListingCard(itinerary: test)
            .background(Color.themeBackground)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
