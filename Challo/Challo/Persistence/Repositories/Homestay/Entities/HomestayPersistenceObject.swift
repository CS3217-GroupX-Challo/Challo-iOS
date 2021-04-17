//
//  HomestayPersistenceObject.swift
//  Challo
//
//  Created by Kester Ng on 18/4/21.
//

import CoreData
import Foundation
import MapKit

struct HomestayPersistenceObject {
    let homestayId: UUID
    
    let title: String
    
    let description: String?

    /// Paths to images of the homestay
    let images: [String]

    let location: CLLocationCoordinate2D

    let rating: Double

    let fee: Double

    let capacity: HomestayCapacityPersistenceObject

    let amenities: [Amenity]

    let guests: Int

    let host: HostPersistenceObject
}

extension HomestayPersistenceObject: CoreDataPersistenceObject {
    init?(entity: NSManagedObject) {
        guard let homestay = entity as? HomestayDetails,
              let homestayId = homestay.id,
              let title = homestay.title,
              let imagesString = homestay.image,
              let bedroomsString = homestay.bedroom,
              let amentiyString = homestay.amenities,
              let host = homestay.host,
              let hostObject = HostPersistenceObject(entity: host) else {
            return nil
        }
        
        self.homestayId = homestayId
        self.title = title
        self.images = imagesString.constructArray()
        
        var amenities = [Amenity]()
        for string in amentiyString.constructArray() {
            if let amenity = Amenity(rawValue: string) {
                amenities.append(amenity)
            }
        }
        self.amenities = amenities
        self.description = homestay.description
        self.rating = homestay.rating
        self.fee = homestay.fee
        self.guests = Int(homestay.guests)
        self.host = hostObject
        self.location = CLLocationCoordinate2D(latitude: homestay.latitude,
                                               longitude: homestay.longitude)
        
        var bedrooms = [BedroomPersistenceObject]()
        for bedroomString in bedroomsString.constructArray() {
            let splitStringArray = bedroomString.components(separatedBy: "+")
            if splitStringArray.count != 2 {
                continue
            } else {
                if let bed = Bed(rawValue: splitStringArray[0]),
                   let bedQuantity = Int(splitStringArray[1]) {
                    bedrooms.append(BedroomPersistenceObject(bed: bed,
                                                             bedQuantity: bedQuantity))
                }
            }
        }
        self.capacity = HomestayCapacityPersistenceObject(toilets: Int(homestay.toilets),
                                                          bedrooms: bedrooms)
    }
    
    func convertToEntity() -> NSManagedObject {
        let homestayDetails = HomestayDetails(context: CoreDataContainer.managedObjectContext)
        setHomestayDetails(homestayDetails: homestayDetails)
        return homestayDetails
    }
    
    func updateEntity(entity: NSManagedObject) {
        guard let homestayDetails = entity as? HomestayDetails else {
            return
        }
        setHomestayDetails(homestayDetails: homestayDetails)
    }
    
    private func setHomestayDetails(homestayDetails: HomestayDetails) {
        homestayDetails.id = homestayId
        homestayDetails.title = title
        homestayDetails.image = String(array: images)
        
        let amenitiesStringArray = amenities.map { amenity in
            amenity.rawValue
        }
        homestayDetails.amenities = String(array: amenitiesStringArray)
        homestayDetails.latitude = location.latitude
        homestayDetails.longitude = location.longitude
        homestayDetails.rating = rating
        homestayDetails.fee = fee
        homestayDetails.decription = description
        homestayDetails.guests = Int64(guests)
        homestayDetails.toilets = Int64(capacity.toilets)
        
        let bedroomsStringArray = capacity.bedrooms.map { bedroom in
            bedroom.convertToString()
        }
        
        homestayDetails.bedroom = String(array: bedroomsStringArray)
    }
}
