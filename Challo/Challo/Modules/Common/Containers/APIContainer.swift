//
//  APIContainer.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Swinject

class APIContainer {
    
    let container = Container()
    
    init() {
        container.register(NetworkManager.self) { _ in
            APINetwork.getNetworkManager()
        }
        registerAPIs()
    }
    
    // swiftlint:disable function_body_length
    private func registerAPIs() {
        let guideParser = GuideAPIParser()
        let areaParser = AreaAPIParser()
        let trailParser = TrailAPIParser()
        let reviewParser = ReviewAPIParser()
        let touristParser = TouristAPIParser()
        let bookingParser = BookingAPIParser()
        container.register(APIParser.self, name: ContainerNames.guide.rawValue) { _ in
            guideParser
        }
        container.register(APIParser.self, name: ContainerNames.area.rawValue) { _ in
            areaParser
        }
        container.register(APIParser.self, name: ContainerNames.trail.rawValue) { _ in
            trailParser
        }
        container.register(APIParser.self, name: ContainerNames.review.rawValue) { _ in
            reviewParser
        }
        container.register(APIParser.self, name: ContainerNames.tourist.rawValue) { _ in
            touristParser
        }
        container.register(APIParser.self, name: ContainerNames.booking.rawValue) { _ in
            bookingParser
        }
        
        guard let networkManager = container.resolve(NetworkManager.self) else {
            fatalError("Failed to resolve NetworkManager in APIContainer")
        }
        let trailAPI = TrailAPI(parser: trailParser, networkManager: networkManager)
        let guideAPI = GuideAPI(guideParser: guideParser, trailParser: trailParser, networkManager: networkManager)
        let touristAPI = TouristAPI(touristParser: touristParser, networkManager: networkManager)
        let reviewAPI = ReviewAPI(reviewParser: reviewParser,
                                  trailAPI: trailAPI,
                                  touristAPI: touristAPI,
                                  guideAPI: guideAPI,
                                  networkManager: networkManager)
        let bookingAPI = BookingAPI(bookingParser: bookingParser,
                                    networkManager: networkManager,
                                    guideAPI: guideAPI,
                                    touristAPI: touristAPI,
                                    trailAPI: trailAPI,
                                    reviewAPI: reviewAPI)
        container.register(GuideAPIProtocol.self) { _ in
            guideAPI
        }
        container.register(TrailAPIProtocol.self) { _ in
            trailAPI
        }
        container.register(TouristAPIProtocol.self) { _ in
            touristAPI
        }
        container.register(ReviewAPIProtocol.self) { _ in
            reviewAPI
        }
        container.register(AreaAPIProtocol.self, name: ContainerNames.area.rawValue) { _ in
            AreaAPI(areaParser: areaParser, networkManager: networkManager)
        }
        container.register(BookingAPIProtocol.self) { _ in
            bookingAPI
        }
    }
}
