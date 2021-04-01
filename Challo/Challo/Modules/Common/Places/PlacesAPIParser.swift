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
        guard let location = json["location"] as? JSON,
              let latitude = location["lat"] as? String,
              let longitude = location["lng"] as? String,
              let name = json["name"] as? String,
              let rating = json["rating"] as? String,
              let isOpenJSON = json["opening_hours"] as? JSON,
              let isOpen = isOpenJSON["open_now"] as? Bool,
              let address = json["formatted_address"] as? String else {
            return nil
        }
        
        return Place(longitude: Double(latitude) ?? 0, latitude: Double(longitude) ?? 0,
                     name: name, rating: Double(rating) ?? 0,
                     isOpen: isOpen, address: address)
    }
}
