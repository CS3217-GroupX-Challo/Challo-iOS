//
//  HomestayProfileDetails.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfileDetails: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter

    var body: some View {
        UnwrapView(presenter.currentEntity) { homestay in
            VStack(alignment: .leading) {
                HomestayProfileTitle(title: homestay.title, numOfGuests: homestay.guests)
                EntityProfileDivider()
                HomestayProfileDescription(description: homestay.description ?? "")
                EntityProfileDivider()
                HomestayProfileAmenities(amenities: homestay.amenities)
                EntityProfileDivider()
                HomestayCapacityView(capacity: homestay.capacity)
                EntityProfileDivider()
                EntityProfileLocation(location: homestay.location)
            }
        }
    }
}
