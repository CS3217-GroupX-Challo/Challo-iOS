//
//  SettingsRouter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

class SettingsRouter: RouterProtocol {
    weak var presenter: SettingsPresenter!
    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }
        
    func getLoginPage() -> AnyView {
        TouristLoginModule.assemble(userState: userState).view
    }
}
