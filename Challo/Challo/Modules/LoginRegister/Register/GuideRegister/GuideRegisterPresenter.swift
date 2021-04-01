//
//  GuideRegisterPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterPresenter: RegisterPresenter, PresenterProtocol, ObservableObject {

    var interactor: RegisterInteractor!
    var router: RegisterRouter?
    
    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
<<<<<<< HEAD
    @Published var isShowingRegisterAlert = false
    @Published var registerAlertTitle = ""
    @Published var registerAlertMessage = ""
=======
    @Published var isShowingRegisterFailureAlert = false
    @Published var isShowingRegisterSuccessAlert = false
>>>>>>> master
}
