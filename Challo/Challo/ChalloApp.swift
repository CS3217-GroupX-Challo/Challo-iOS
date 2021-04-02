//
//  ChalloApp.swift
//  Challo
//
//  Created by Tan Le Yang on 12/3/21.
//

import SwiftUI
import FBSDKCoreKit

@main
struct ChalloApp: App {

    private let globalUserState: UserStateProtocol
    
    init() {
        globalUserState = UserState()
        GoogleMapsConfiguration.initConfiguration()
        QuickBloxConfiguration.initConfiguration()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(userState: globalUserState)
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
