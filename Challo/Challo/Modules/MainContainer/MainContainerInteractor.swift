//
//  MainContainerInteractor.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

class MainContainerInteractor: InteractorProtocol {

    weak var presenter: MainContainerPresenter!
    let userState: UserStateProtocol!

    init(userState: UserStateProtocol) {
        self.userState = userState
        
        let chatService = QuickBloxChatService()
        chatService.login(email: "random@random.sg", password: "asfsdfsff")
    }
    
    func checkIfUserLoggedIn() -> Bool {
        userState.loggedIn
    }
}
