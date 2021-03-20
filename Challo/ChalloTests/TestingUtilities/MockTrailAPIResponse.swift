//
//  MockTrailAPIResponse.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import Foundation
import MapKit

struct MockTrailAPIResponse: MockAPIResponse {
    typealias JSON = NetworkManager.JSON
    
    static let areaParser = AreaAPIParser()
    
    static let trailIdOne = UUID(uuidString: "6d38efad-27ec-4c9b-af77-ff40414e4aa4") ?? UUID()
    static let titleOne: String = "Sunkiya Forest Trail"
    static let descriptionOne: String = "A very nice trail!"
    static let distanceOne = Decimal(1_500)
    static let elevationOne = Decimal(1_200)
    static let durationOne = Decimal(600)
    static let imagesOne: [String] = ["test.img", "hello.img"]
    
    static var areaOne: JSON {
        var json = JSON()
        json[Key.areaId] = UUID(uuidString: "3fa85f64-5717-4562-b3fc-2c963f66afa6")?.uuidString ?? UUID().uuidString
        json[Key.country] = "India"
        json[Key.state] = "Uttarakhand"
        json[Key.village] = "village"
        json[Key.division] = "division3"
        return json
    }
    
    static var positionsOne: [JSON] {
        var json = JSON()
        json[Key.lattitude] = 29.5
        json[Key.longitude] = 31.5
        return [json]
    }
    
    static var trailJSONOne: JSON {
        var json = JSON()
        json[Key.trailId] = trailIdOne.uuidString
        json[Key.description] = descriptionOne
        json[Key.positions] = positionsOne
        json[Key.distance] = distanceOne.description
        json[Key.elevation] = elevationOne.description
        json[Key.duration] = durationOne.description
        json[Key.images] = imagesOne
        json[Key.area] = areaOne
        json[Key.title] = titleOne
        return json
    }
    
    static var trailOne: Trail? {
        guard let area = areaParser.convertJSONToArea(json: areaOne) else {
            return nil
        }
        
        return Trail(trailId: trailIdOne, title: titleOne, description: descriptionOne,
                     positions: convertJSONToCLLCoordinatesArray(json: positionsOne),
                     distance: distanceOne, duration: durationOne,
                     elevation: elevationOne, images: imagesOne, area: area)
    }
        
    static let trailIdTwo = UUID(uuidString: "8646f41e-5246-4b73-b694-b7106326e6e2") ?? UUID()
    static let titleTwo: String = "Sunkiya Forest Trail"
    static let descriptionTwo: String = "A very nice trail! Yay!"
    static let distanceTwo = Decimal(150)
    static let elevationTwo = Decimal(100)
    static let durationTwo = Decimal(6_020)
    static let imagesTwo: [String] = ["test.img", "hello.img", "byebye.img"]
    
    static var areaTwo: JSON {
        var json = JSON()
        json[Key.areaId] = UUID(uuidString: "3fa85f64-5717-4562-b3fc-2c963f66afa6")?.uuidString ?? UUID().uuidString
        json[Key.country] = "India"
        json[Key.state] = "Uttarakhand"
        json[Key.village] = "village"
        json[Key.division] = "division3"
        return json
    }
    
    static var positionsTwo: [JSON] {
        var json = JSON()
        json[Key.lattitude] = 29.5
        json[Key.longitude] = 31.5
        return [json]
    }
    
    static var trailJSONTwo: JSON {
        var json = JSON()
        json[Key.trailId] = trailIdTwo.uuidString
        json[Key.description] = descriptionTwo
        json[Key.positions] = positionsTwo
        json[Key.distance] = distanceTwo.description
        json[Key.elevation] = elevationTwo.description
        json[Key.duration] = durationTwo.description
        json[Key.images] = imagesTwo
        json[Key.area] = areaTwo
        json[Key.title] = titleTwo
        return json
    }
    
    static var trailTwo: Trail? {
        guard let area = areaParser.convertJSONToArea(json: areaOne) else {
            return nil
        }
        
        return Trail(trailId: trailIdTwo, title: titleTwo, description: descriptionTwo,
                     positions: convertJSONToCLLCoordinatesArray(json: positionsTwo),
                     distance: distanceTwo, duration: durationTwo,
                     elevation: elevationTwo, images: imagesTwo, area: area)
    }
    
    static var response: JSON {
        var json = JSON()
        json["message"] = "Got trails"
        json["data"] = [trailJSONOne, trailJSONTwo]
        return json
    }
}

extension MockTrailAPIResponse {
    static func convertJSONToCLLCoordinatesArray(json: [JSON]?) -> [CLLocationCoordinate2D] {
        guard let coordinateDetails = json else {
            return []
        }
        
        var coordinates = [CLLocationCoordinate2D]()
        for coordinateDetail in coordinateDetails {
            if let lattitude = coordinateDetail[Key.lattitude] as? Double,
               let longitude = coordinateDetail[Key.longitude] as? Double {
                coordinates.append(CLLocationCoordinate2D(latitude: CLLocationDegrees(lattitude),
                                                          longitude: CLLocationDegrees(longitude)))
            }
        }
        return coordinates
    }
}
