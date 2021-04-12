//
//  TouristLoginPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

class TouristLoginPresenter: LoginPresenter, ObservableObject {

    var interactor: TouristLoginInteractor!
    var router: TouristLoginRouter?

    @Published var email = ""
    @Published var password = ""
    @Published var isShowingLoginFailureAlert = false
}
