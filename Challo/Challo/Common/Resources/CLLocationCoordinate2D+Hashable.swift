//
//  CLLocationCoordinate2D+Hashable.swift
//  Challo
//
//  Created by Kester Ng on 3/4/21.
//

import MapKit

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
