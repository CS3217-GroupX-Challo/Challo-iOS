//
//  MockPlacesAPIResponse.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

import Foundation
@testable import Challo
import MapKit

struct MockPlacesAPIResponse: MockAPIResponse {
    typealias JSON = NetworkManager.JSON
    
    static let id = UUID()
    static let longitude: CLLocationDegrees = 10
    static let latitude: CLLocationDegrees = 16
    static let name = "NUS"
    static let rating = 0.1
    static let isOpen = true
    static let address = "Address"
    
    static var validPlacesJSON: JSON {
        var json = JSON()
        json[Key.googleAddress] = address
        json[Key.googleRating] = rating
        json[Key.googleName] = name
        
        var geometry = JSON()
        var location = JSON()
        location[Key.googleLatitude] = latitude
        location[Key.googleLongitude] = longitude
        geometry[Key.googleLocation] = location
        json[Key.googleGeometry] = geometry
        
        var opening = JSON()
        opening[Key.googleOpenNow] = 1
        json[Key.googleOpeningHours] = opening
        return json
    }
    
    static var validResponse: JSON {
        var json = JSON()
        json["candidates"] = [validPlacesJSON]
        return json
    }
    
    static var place: Place {
        Place(id: id,
              longitude: longitude,
              latitude: latitude,
              name: name,
              rating: rating,
              isOpen: isOpen,
              address: address)
    }
}
