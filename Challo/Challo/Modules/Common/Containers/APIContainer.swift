//
//  APIContainer.swift
//  Challo
//
//  Created by Shao Yi on 29/3/21.
//

import Swinject

class APIContainer {
    
    let container = Container()
    
    init(userState: UserStateProtocol) {
        container.register(NetworkManager.self) { _ in
            APINetwork.getNetworkManager()
        }
        registerAPIs(userState)
    }
    
    // swiftlint:disable function_body_length
    private func registerAPIs(_ userState: UserStateProtocol) {
        let guideParser = GuideAPIParser()
        let areaParser = AreaAPIParser()
        let trailParser = TrailAPIParser()
        let reviewParser = ReviewAPIParser()
        let touristParser = TouristAPIParser()
        let bookingParser = BookingAPIParser()
        let placesParser = PlacesAPIParser()
        let hostParser = HostAPIParser()
        let homestayParser = HomestayAPIParser()
        let userParser = UserAPIParser(userState: userState)
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
        container.register(APIParser.self, name: ContainerNames.host.rawValue) { _ in
            hostParser
        }
        container.register(APIParser.self, name: ContainerNames.homestay.rawValue) { _ in
            homestayParser
        }
        
        guard let networkManager = container.resolve(NetworkManager.self) else {
            fatalError("Failed to resolve NetworkManager in APIContainer")
        }
        let hostAPI = HostAPI(hostParser: hostParser, networkManager: networkManager)
        let homestayAPI = HomestayAPI(homestayParser: homestayParser, hostAPI: hostAPI, networkManager: networkManager)
        let userAPI = UserAPI(userParser: userParser, networkManager: networkManager)
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
        
        let alamofireManager = AlamofireManager.alamofireManager
        alamofireManager.apiPath = ProcessInfo.processInfo.environment["google_places_path"]
        
        let placesAPI = PlacesAPI(parser: placesParser,
                                  networkManager: alamofireManager)
        container.register(PlacesAPIProtocol.self) { _ in
            placesAPI
        }
        container.register(UserAPIProtocol.self) { _ in
            userAPI
        }
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
        container.register(AreaAPIProtocol.self) { _ in
            AreaAPI(areaParser: areaParser, networkManager: networkManager)
        }
        container.register(BookingAPIProtocol.self) { _ in
            bookingAPI
        }
        container.register(HostAPIProtocol.self) { _ in
            hostAPI
        }
        container.register(HomestayAPIProtocol.self) { _ in
            homestayAPI
        }
        container.register(LoginAPI.self, name: ContainerNames.tourist.rawValue) { _ in
            TouristLoginAPI(userAPI: userAPI)
        }
        container.register(LoginAPI.self, name: ContainerNames.guide.rawValue) { _ in
            GuideLoginAPI(userAPI: userAPI)
        }
        container.register(RegisterAPI.self, name: ContainerNames.tourist.rawValue) { _ in
            TouristRegistrationAPI(userAPI: userAPI)
        }
        container.register(RegisterAPI.self, name: ContainerNames.guide.rawValue) { _ in
            GuideRegistrationAPI(userAPI: userAPI)
        }
    }
}
