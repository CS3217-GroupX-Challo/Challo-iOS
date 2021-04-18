//
//  HomestayProfileAmenities.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

struct HomestayProfileAmenities: View {
    @EnvironmentObject var presenter: HomestayProfilePresenter

    let amenities: [Amenity]
    
    var body: some View {
        VStack(alignment: .leading) {
            EntityProfileSectionTitle(title: "Amenities")
            VStack(alignment: .leading, spacing: 10) {
                ForEach(amenities, id: \.self) { amenity in
                    HStack {
                        Text(amenity.rawValue)
                        Spacer()
                        Image(systemName: amenity.getIcon())
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }.padding(.horizontal, 15)
        }
    }
}
