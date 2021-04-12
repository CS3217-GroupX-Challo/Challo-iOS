//
//  CLLocationCoordinate2D+String.swift
//  Challo
//
//  Created by Kester Ng on 12/4/21.
//

import MapKit

extension CLLocationCoordinate2D {
    func toString() -> String {
        "\(self.latitude), \(self.longitude)"
    }
    
    init?(str: String) {
        let array = str.components(separatedBy: ", ")
        guard array.count == 2 else {
            return nil
        }
        
        guard let latitude = Double(array[0]),
              let longitude = Double(array[1]) else {
            return nil
        }
            
        self.init(latitude: latitude, longitude: longitude)
    }
}
