//
//  CLLocationCoordinate2D+Equatable.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import MapKit

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
