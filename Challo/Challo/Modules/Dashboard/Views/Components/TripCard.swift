//
//  TripCard.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

struct TripCard: View {

    // TODO: remove, just for testing
    static var trips: [Trip] {
        let tripName = "Beginner Himalayan Introduction"
        let tripDate = Date(timeIntervalSinceReferenceDate: 10_000)
        let guideName = "Challo Naveen"
        let duration = "3 hours"
        let trip = Trip(tripName: tripName,
                        tripDate: tripDate,
                        duration: duration,
                        guideName: guideName)
        
        return [trip, trip, trip, trip, trip]
    }

    var trip: Trip
    var width: CGFloat
    
    var body: some View {
        Card {
            Image.mountainBackground
                .resizable()
                .scaledToFit()
                .frame(width: width * 4 / 5)
                .cornerRadius(10)
                .padding(10)
            Text(trip.tripName)
                .font(.subheadline)
                .foregroundColor(.themeAccent)
                .bold()
            HStack {
                Text(trip.tripDate, style: .date)
                Text(", \(trip.duration)")
            }
            .foregroundColor(.themeForeground)
            .font(.caption)
            Text("Guide: \(trip.guideName)")
        }
        .frame(width: width,
               alignment: .center)
    }
}

struct TripCard_Previews: PreviewProvider {
    static var previews: some View {
        let previewWidth: CGFloat = 300.0
        let tripName = "Beginner Himalayan Introduction"
        let tripDate = Date(timeIntervalSinceReferenceDate: 10_000)
        let guideName = "Challo Naveen"
        let duration = "3 hours"
        let trip = Trip(tripName: tripName,
                        tripDate: tripDate,
                        duration: duration,
                        guideName: guideName)
        TripCard(trip: trip,
                 width: previewWidth)
            .previewLayout(.fixed(width: previewWidth, height: 300))
    }
}
