//
//  MainContainerInteractor.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

class MainContainerInteractor: InteractorProtocol {

    weak var presenter: MainContainerPresenter!
    
    private var userState = UserState.globalState
    
    func checkIfUserLoggedIn() -> Bool {
        userState.loggedIn
    }
}
