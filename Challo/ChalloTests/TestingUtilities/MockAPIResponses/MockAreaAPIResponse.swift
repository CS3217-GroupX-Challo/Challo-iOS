//
//  MockAreaAPIResponse.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo
import Foundation

struct MockAreaAPIResponse: MockAPIResponse {

    typealias JSON = NetworkManager.JSON

    static let areaIdOne = UUID(uuidString: "3fa85f64-5717-4562-b3fc-2c963f66afa6") ?? UUID()
    static let villageOne = "village"
    static let divisionOne = "division"
    static let stateOne = "state"
    static let countryOne = "India"

    static var areaJSONOne: JSON {
        var json = JSON()
        json[Key.areaId] = areaIdOne.uuidString
        json[Key.village] = villageOne
        json[Key.division] = divisionOne
        json[Key.state] = stateOne
        json[Key.country] = countryOne
        return json
    }

    static var areaStateOne: Area {
        Area(areaId: areaIdOne,
             village: villageOne,
             division: divisionOne,
             state: stateOne,
             country: countryOne)
    }

    static let areaIdTwo = UUID(uuidString: "eff7f093-87ed-4eb4-bc01-8adf9a7ac71d") ?? UUID()
    static let villageTwo = "village2"
    static let divisionTwo = "division2"
    static let stateTwo = "state2"
    static let countryTwo = "India2"

    static var areaJSONTwo: JSON {
        var json = JSON()
        json[Key.areaId] = areaIdTwo.uuidString
        json[Key.village] = villageTwo
        json[Key.division] = divisionTwo
        json[Key.state] = stateTwo
        json[Key.country] = countryTwo
        return json
    }

    static var areaStateTwo: Area {
        Area(areaId: areaIdTwo,
             village: villageTwo,
             division: divisionTwo,
             state: stateTwo,
             country: countryTwo)
    }

    static var validAreaResponse: JSON {
        var json = JSON()
        json["message"] = "Area found"
        json["data"] = [areaJSONOne, areaJSONTwo]
        return json
    }
}
