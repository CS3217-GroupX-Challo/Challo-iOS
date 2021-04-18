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
    
    @Published var isNewUser = false
    @Published var loggedIn = false {
        willSet { objectWillChange.send() }
        didSet { storedLoggedIn = loggedIn }
    }

    @AppStorage("logged_in") private var storedLoggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("name") var name = ""
    @AppStorage("token") var token = ""
    @AppStorage("userId") var userId = ""
    @AppStorage("profileImg") var profileImg = ""
    @Published var user: User?

    private static var instances = 0

    init() {
        guard UserState.instances == 0 else {
            ChalloLogger.logger.fault("Attempted to spawn another UserState")
            fatalError("UserState should not be initiailised more than once")
        }
        loggedIn = storedLoggedIn
        UserState.instances += 1
    }

    var certificate: UserCertificate? {
        guard loggedIn else {
            return nil
        }
        return UserCertificate(name: name,
                               email: email,
                               profileImg: profileImg,
                               token: token,
                               userId: userId)
    }
}
