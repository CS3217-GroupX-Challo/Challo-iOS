//
//  ChalloApp.swift
//  Challo
//
//  Created by Tan Le Yang on 12/3/21.
//

import SwiftUI
import FBSDKCoreKit
import GoogleMaps
import GooglePlaces

@main
struct ChalloApp: App {
    
    init() {
        guard let apiKey = ProcessInfo.processInfo.environment["google_maps_api_key"] else {
            return
        }
        GMSServices.provideAPIKey(apiKey)
        GMSPlacesClient.provideAPIKey(apiKey)
        ChalloLogger.logger.info("Google API has been set!")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    ApplicationDelegate.shared.application(
                        UIApplication.shared,
                        open: url,
                        sourceApplication: nil,
                        annotation: UIApplication.OpenURLOptionsKey.annotation)
                })
        }
    }
}
