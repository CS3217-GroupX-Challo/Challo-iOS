//
//  TouristRegisterPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class TouristRegisterPresenter: RegisterPresenter, ObservableObject {

    var interactor: TouristRegisterInteractor!
    var router: TouristRegisterRouter?

    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isShowingRegisterAlert = false
    @Published var registerAlertTitle = ""
    @Published var registerAlertMessage = ""

}
