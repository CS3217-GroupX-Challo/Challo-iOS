//
//  SettingsInteractor.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

class SettingsInteractor: InteractorProtocol {
    weak var presenter: SettingsPresenter!
    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func onTapLogOut() {
        userState.logOut()
    }
}
