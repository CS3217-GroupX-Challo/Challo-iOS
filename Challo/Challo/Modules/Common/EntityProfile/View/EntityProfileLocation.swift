//
//  EntityProfileLocation.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI
import MapKit

struct EntityProfileLocation: View {
    @State var mapRegion: MKCoordinateRegion

    init(location: CLLocationCoordinate2D) {
        _mapRegion = State(initialValue: MKCoordinateRegion(center: location,
                                                            span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                                                   longitudeDelta: 0.005)))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            EntityProfileSectionTitle(title: "Location")
            Map(coordinateRegion: $mapRegion, interactionModes: MapInteractionModes.all)
                .cornerRadius(10)
        }.frame(minHeight: 350)
    }
}
