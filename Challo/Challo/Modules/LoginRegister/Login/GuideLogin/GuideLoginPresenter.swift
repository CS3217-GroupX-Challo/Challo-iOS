//
//  GuidesLoginPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class GuideLoginPresenter: LoginPresenter, ObservableObject {

    var interactor: GuideLoginInteractor!
    var router: GuideLoginRouter?

    @Published var email = ""
    @Published var password = ""
    @Published var isShowingLoginFailureAlert = false
}
