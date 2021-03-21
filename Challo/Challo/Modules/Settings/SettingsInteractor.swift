//
//  SettingsInteractor.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

class SettingsInteractor: InteractorProtocol {
    var presenter: SettingsPresenter!
    
    func onTapLogOut() {
        UserState.globalState.logOut()
    }
}
