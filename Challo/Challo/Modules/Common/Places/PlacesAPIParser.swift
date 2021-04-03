//
//  PlacesAPIParser.swift
//  Challo
//
//  Created by Kester Ng on 1/4/21.
//

import Foundation

class PlacesAPIParser: APIParser {
    typealias JSON = NetworkManager.JSON
    
    func parsePlaces(response: JSON) -> [Place] {
        guard let candidates = response["candidates"],
              let placesInfo = candidates as? [JSON] else {
            return []
        }
        
        var places = [Place]()
        for placeInfo in placesInfo {
            if let place = convertPlaceJSONToPlace(json: placeInfo) {
                places.append(place)
            }
        }
        
        return places
    }
    
    func convertPlaceJSONToPlace(json: JSON) -> Place? {
        guard let geometry = json[Key.googleGeometry] as? JSON,
              let location = geometry[Key.googleLocation] as? JSON,
              let latitude = location[Key.googleLatitude] as? Double,
              let longitude = location[Key.googleLongitude] as? Double,
              let name = json[Key.googleName] as? String,
              let rating = json[Key.googleRating] as? Double,
              let address = json[Key.googleAddress] as? String else {
            return nil
        }

        let isOpen: Bool
        
        if let isOpenJSON = json[Key.googleOpeningHours] as? JSON {
            let openNowInt = isOpenJSON[Key.googleOpenNow] as? Int ?? 1
            isOpen = openNowInt == 1
        } else {
            isOpen = true
        }
        
        return Place(longitude: longitude, latitude: latitude,
                     name: name, rating: rating,
                     isOpen: isOpen, address: address)
    }
}
