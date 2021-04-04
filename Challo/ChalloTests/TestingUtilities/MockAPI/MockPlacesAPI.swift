//
//  MockPlacesAPI.swift
//  ChalloTests
//
//  Created by Kester Ng on 2/4/21.
//

@testable import Challo
import Foundation

class MockPlacesAPI: PlacesAPI {

    static let correctName = "Test place"
    static let placeOne = Place(id: UUID(),
                                longitude: 25,
                                latitude: 111,
                                name: "Test place",
                                rating: 4.5,
                                isOpen: true,
                                address: "Test address")
    static let placeTwo = Place(id: UUID(),
                                longitude: 33,
                                latitude: 123,
                                name: "Test place two",
                                rating: 4.2,
                                isOpen: false,
                                address: "Test address two")
    static let places = [placeOne, placeTwo]

    init() {
        super.init(parser: MockPlacesAPIParser(),
                   networkManager: MockNetworkManager(json: NetworkManager.JSON()))
    }

    override func getPlaces(with name: String, callback: @escaping ([Place]) -> Void) {
        if name != Self.correctName {
            callback([])
            return
        }
        callback(Self.places)
    }
}
