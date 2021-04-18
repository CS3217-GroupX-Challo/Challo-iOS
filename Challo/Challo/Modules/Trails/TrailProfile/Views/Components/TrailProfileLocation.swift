//
//  TrailProfileLocation.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI
import MapKit

struct TrailProfileLocation: View {
    
    let startingPoint: CLLocationCoordinate2D
    @State var mapRegion: MKCoordinateRegion

    init(trail: Trail) {
        startingPoint = trail.positions[0]
        _mapRegion = State(initialValue: MKCoordinateRegion(center: startingPoint,
                                                            span: MKCoordinateSpan(latitudeDelta: 0.005,
                                                                                   longitudeDelta: 0.005)))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TrailProfileSectionTitle(title: "Location")
            Map(coordinateRegion: $mapRegion, interactionModes: MapInteractionModes.all)
                .cornerRadius(10)
        }.frame(minHeight: 350)
    }
}
