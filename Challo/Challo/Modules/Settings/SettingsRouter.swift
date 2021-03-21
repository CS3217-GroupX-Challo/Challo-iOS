//
//  SettingsRouter.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

class SettingsRouter: RouterProtocol {
    weak var presenter: SettingsPresenter!
        
    func getLoginPage() -> AnyView {
        TouristLoginModule.assemble().view
    }
}
