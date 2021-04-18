//
//  HomestayProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

class HomestayProfilePresenter: EntityProfilePresenter, ObservableObject {

    var interactor: HomestayProfileInteractor!
    var router: HomestayProfileRouter?

    @Published var isShowingNotLoggedInAlert = false

    var currentEntity: Homestay?
    
    func populateProfilePage(_ entity: Homestay) {
        currentEntity = entity
    }
}
