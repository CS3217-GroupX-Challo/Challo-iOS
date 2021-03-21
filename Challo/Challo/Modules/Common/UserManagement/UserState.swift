//
//  UserState.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//

import SwiftUI

/**
 Singleton that holds the general state of the user
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

    // reset user defaults for testing
    private init() {
        self.loggedIn = false
    }
    
    func logOut() {
        loggedIn = false
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
