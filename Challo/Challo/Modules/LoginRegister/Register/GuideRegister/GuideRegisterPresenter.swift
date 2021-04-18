//
//  GuideRegisterPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterPresenter: RegisterPresenter, ObservableObject {

    var interactor: GuideRegisterInteractor!
    var router: GuideRegisterRouter?
    
    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isShowingRegisterAlert = false
    @Published var registerAlertTitle = ""
    @Published var registerAlertMessage = ""

    @Published var registrationComplete = false

}
