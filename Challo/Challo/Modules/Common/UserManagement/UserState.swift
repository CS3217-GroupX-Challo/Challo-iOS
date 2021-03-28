//
//  UserState.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//

import SwiftUI

/**
 General state of user.
 */
class UserState: UserStateProtocol, ObservableObject {
    
    @Published var loggedIn = false {
        willSet { objectWillChange.send() }
        didSet { storedLoggedIn = loggedIn }
    }
    @AppStorage("logged_in") private var storedLoggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("name") var name = ""
    @AppStorage("token") var token = ""
    @AppStorage("userId") var userId = ""
    var user: User?

    static var globalState: UserState = globalInstance
    private static let globalInstance = UserState()

    private static var instances = 0

    init() {
        guard UserState.instances == 0 else {
            ChalloLogger.logger.fault("Attempted to spawn another UserState")
            fatalError("UserState should not be initiailised more than once")
        }
        loggedIn = false
        UserState.instances += 1
    }

    /// Sample user state strictly for use in previews. Do NOT use it beyond that.
    internal static var sampleUserState: UserState {
        let initialCount = instances
        instances = 0
        let sample = UserState()
        instances = initialCount
        return sample
    }

    var certificate: UserCertificate? {
        guard loggedIn else {
            return nil
        }
        return UserCertificate(name: name,
                               email: email,
                               token: token,
                               userId: userId)
    }
}
