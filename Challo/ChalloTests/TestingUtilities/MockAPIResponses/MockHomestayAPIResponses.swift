//
//  MockHomestayAPIResponses.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 16/4/21.
//

import Foundation
import MapKit
@testable import Challo

struct MockHomestayAPIResponses {
    typealias JSON = NetworkManager.JSON

    static let homestayIdOne = UUID(uuidString: "3fa85f64-5717-4562-b3fc-2c963f66afa6")!
    static let hostIdOne = MockHostAPIResponses.userId
    static let hostOne = MockHostAPIResponses.host
    static let titleOne = "4 Room Delxue homestay with great view!"
    static let descriptionOne = "Super luxurious with a great view of the mountain ranges! :)"
    static let imagesPathOne = ["imgOne.png", "imgTwo.png"]
    static let lattitudeOne: Double = 23.568
    static let longitudeOne: Double = 123.456
    static var locationJSONOne: JSON {
        var json = JSON()
        json[Key.lattitude] = lattitudeOne
        json[Key.longitude] = longitudeOne
        return json
    }
    static let locationOne = CLLocationCoordinate2D(latitude: lattitudeOne,
                                                    longitude: longitudeOne)
    static let ratingOne: Double = 1.5
    static let ratingJSONDoubleOne = String(ratingOne)
    static let feeOne: Int = 10
    static var bedroomJSONOne: JSON {
        var json = JSON()
        json[Key.bed] = "King"
        json[Key.quantity] = 1
        return json
    }
    static var bedroomJSONOneA: JSON {
        var json = JSON()
        json[Key.bed] = "Queen"
        json[Key.quantity] = 1
        return json
    }
    static var capacityJSONOne: JSON {
        var json = JSON()
        json[Key.toilets] = 5
        json[Key.bedrooms] = [bedroomJSONOne, bedroomJSONOneA]
        return json
    }
    static var capacityOne: HomestayCapacity {
        let bedroomOne = Bedroom(bed: .king, bedQuantity: 1)
        let bedroomTwo = Bedroom(bed: .queen, bedQuantity: 1)
        return HomestayCapacity(toilets: 5, bedrooms: [bedroomOne, bedroomTwo])
    }
    static let amenitiesJSONOne = ["Essentials", "Wifi"]
    static let amenitiesOne: [Amenity] = [.essentials, .wifi]
    static let guestsOne: Int = 5

    static var homestayJSONOne: JSON {
        var json = JSON()
        json[Key.homestayId] = homestayIdOne.uuidString
        json[Key.title] = titleOne
        json[Key.description] = descriptionOne
        json[Key.imagesPath] = imagesPathOne
        json[Key.location] = locationJSONOne
        json[Key.rating] = ratingJSONDoubleOne
        json[Key.fee] = feeOne
        json[Key.capacity] = capacityJSONOne
        json[Key.amenities] = amenitiesJSONOne
        json[Key.guests] = guestsOne
        json[Key.hostId] = hostIdOne.uuidString
        return json
    }

    static var homestayOne: Homestay {
        Homestay(homestayId: homestayIdOne, title: titleOne, description: descriptionOne, images: imagesPathOne,
                 location: locationOne, rating: ratingOne, fee: Double(feeOne), capacity: capacityOne,
                 amenities: amenitiesOne, guests: guestsOne, host: MockHostAPIResponses.host)
    }

    static let homestayJSONArray = [homestayJSONOne, homestayJSONOne]
    static let homestays: [Homestay] = [homestayOne, homestayOne]

    static var validResponse: JSON {
        var json = JSON()
        json["data"] = homestayJSONArray
        return json
    }
}
