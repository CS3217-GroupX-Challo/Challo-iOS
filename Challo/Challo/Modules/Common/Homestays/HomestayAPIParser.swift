//
//  HomestayAPIParser.swift
//  Challo
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import MapKit

class HomestayAPIParser: APIParser {

    typealias JSON = NetworkManager.JSON

    func extractHostId(json: JSON) -> UUID? {
        guard let idString = json[Key.hostId] as? String,
              let hostId = UUID(uuidString: idString) else {
            return nil
        }
        
        return hostId
    }

    func extractHomestayJSON(response: JSON) -> [JSON] {
        guard let data = response["data"],
              let homestayInfo = data as? [JSON] else {
            return []
        }
        
        return homestayInfo
    }

    func convertJSONToHomestay(json: JSON, host: Host) -> Homestay? {
        guard let idString = json[Key.homestayId] as? String,
              let homestayId = UUID(uuidString: idString),
              let title = json[Key.title] as? String,
              let location = extractLocation(json: json),
              let capacity = extractCapacity(json: json) else {
            return nil
        }
        
        let images = json[Key.imagesPath] as? [String] ?? []
        let description = json[Key.description] as? String
        let fee = Double(convertJSONIntValueToInt(json[Key.fee]))
        let rating = convertJSONDoubleValueToDouble(json[Key.rating])
        let guests = convertJSONIntValueToInt(json[Key.guests])
        let amenities = extractAmenities(json: json)
                
        return Homestay(homestayId: homestayId,
                        title: title,
                        description: description,
                        images: images,
                        location: location,
                        rating: rating,
                        fee: fee,
                        capacity: capacity,
                        amenities: amenities,
                        guests: guests,
                        host: host)
    }
}

// MARK: Private
extension HomestayAPIParser {

    private func extractLocation(json: JSON) -> CLLocationCoordinate2D? {
        guard let locationJSON = json[Key.location] as? JSON else {
            return nil
        }
        
        return convertJSONLocationToCLLocation2D(locationJSON)
    }

    private func extractCapacity(json: JSON) -> HomestayCapacity? {
        guard let rawCapacity = json[Key.capacity] as? JSON else {
            return nil
        }
        
        let bedrooms = extractBedrooms(json: rawCapacity)
        let toilets = convertJSONIntValueToInt(rawCapacity[Key.toilets])
        
        return HomestayCapacity(toilets: toilets,
                                bedrooms: bedrooms)
    }

    private func extractBedrooms(json: JSON) -> [Bedroom] {
        guard let rawBedrooms = json[Key.bedrooms] as? [JSON] else {
            return []
        }
        
        return rawBedrooms.compactMap { parseSingleBedroom(json: $0) }
    }
    
    private func parseSingleBedroom(json: JSON) -> Bedroom? {
        guard let rawBedType = json[Key.bed] as? String,
              let bed = Bed(rawValue: rawBedType) else {
            return nil
        }
        
        let quantity = convertJSONIntValueToInt(json[Key.quantity])
        return Bedroom(bed: bed, bedQuantity: quantity)
    }
    
    private func extractAmenities(json: JSON) -> [Amenity] {
        guard let rawAmenities = json[Key.amenities] as? [String] else {
            return []
        }
        
        return rawAmenities.compactMap { Amenity(rawValue: $0) }
    }
}
