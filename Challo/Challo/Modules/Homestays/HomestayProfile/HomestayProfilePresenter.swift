//
//  HomestayProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

class HomestayProfilePresenter: EntityProfilePresenter, ObservableObject {

    var userState: UserStateProtocol
    var interactor: HomestayProfileInteractor!
    var router: HomestayProfileRouter?

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    @Published var isShowingNotLoggedInAlert = false
    
    var userCanMakeBooking: Bool {
        userState.loggedIn
    }

    var currentEntity: Homestay?
    
    func populateProfilePage(_ entity: Homestay) {
        currentEntity = entity
    }
}
