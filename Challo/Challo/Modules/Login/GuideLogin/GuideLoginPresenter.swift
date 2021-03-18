//
//  GuidesLoginPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class GuideLoginPresenter: LoginPresenter, PresenterProtocol {

    var interactor: LoginInteractor!
    var router: LoginRouter?

    @Published var email = ""
    @Published var password = ""
    @Published var isShowingLoginFailureAlert = false
}
