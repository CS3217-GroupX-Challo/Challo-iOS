//
//  GoogleMapsConfiguration.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import GoogleMaps
import GooglePlaces

struct GoogleMapsConfiguration: ThirdPartyAPIConfiguration {
    static func initConfiguration() {
        guard let apiKey = ProcessInfo.processInfo.environment["google_maps_api_key"] else {
            return
        }
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
        ChalloLogger.logger.info("Google API has been set!")
    }
}
