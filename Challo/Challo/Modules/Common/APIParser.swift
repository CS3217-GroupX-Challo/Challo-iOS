//
//  APIParser.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import MapKit

protocol APIParser {
    func convertJSONDoubleValueToDouble(_ value: Any?, defaultValue: Double) -> Double
    func convertJSONIntValueToInt(_ value: Any?, defaultValue: Int) -> Int
    func convertJSONLocationToCLLocation2D(_ json: NetworkManager.JSON) -> CLLocationCoordinate2D?
}

extension APIParser {
    func convertJSONDoubleValueToDouble(_ value: Any?, defaultValue: Double = 0) -> Double {
        Double(value as? String ?? "0") ?? defaultValue
    }
    
    func convertJSONIntValueToInt(_ value: Any?, defaultValue: Int = 0) -> Int {
        value as? Int ?? defaultValue
    }

    func convertJSONLocationToCLLocation2D(_ json: NetworkManager.JSON) -> CLLocationCoordinate2D? {
        guard let lattitude = json[Key.lattitude] as? Double,
              let longitude = json[Key.longitude] as? Double else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: lattitude,
                                      longitude: longitude)
    }
}
