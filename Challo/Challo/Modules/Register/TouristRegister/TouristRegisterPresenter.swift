//
//  TouristRegisterPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class TouristRegisterPresenter: RegisterPresenter, PresenterProtocol {

    var interactor: RegisterInteractor!
    var router: RegisterRouter?

    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isShowingRegisterFailureAlert = false
}
