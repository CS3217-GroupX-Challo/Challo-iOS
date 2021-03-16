//
//  UserState.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//

import SwiftUI

class UserState: ObservableObject {

    @AppStorage("logged_in") var loggedIn = false {
        // have to explicitly do this otherwise view won't update, not sure why...
        willSet { objectWillChange.send() }
    }
    @AppStorage("email") var email = ""
    @AppStorage("name") var name = ""
    @AppStorage("token") var token = ""
    @AppStorage("userId") var userId = ""

    static let globalState = globalInstance
    private static let globalInstance = UserState()

    // reset user defaults for testing
    private init() {
        self.loggedIn = false
    }

    var certificate: UserCertificate? {
        if !loggedIn {
            return nil
        }
        return UserCertificate(name: name,
                               email: email,
                               token: token,
                               userId: userId)
    }
}
