//
//  HomestayListingCardDetail.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayListingCardDetail: View {
    let title: String
    let description: String
    let numberOfBedRoom: Int
    let numberOfBeds: Int
    let numberOfToilets: Int
    let numberOfGuests: Int
    let hasWifi: Bool
    let fee: Int
    
    var verticalBar: some View {
        Text("|")
    }
    
    var capacityDetails: some View {
        HStack {
            Text("\(numberOfGuests) guests")
            verticalBar
            Text("\(numberOfBeds) beds")
            verticalBar
            Text("\(numberOfBedRoom) bedrooms")
            verticalBar
            Text("\(numberOfToilets) toilets")
        }.foregroundColor(Color(.systemGray2))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(title)
                    .bold()
                    .font(.title3)
                Spacer()
            }
            Divider()
            capacityDetails
            Text(description)
                .lineLimit(5)
            Spacer()
            HStack {
                Spacer()
                Text("\(fee) Rp")
                    .bold()
                    .font(.title3) +
                    Text(" / night")
            }
        }
    }
}
