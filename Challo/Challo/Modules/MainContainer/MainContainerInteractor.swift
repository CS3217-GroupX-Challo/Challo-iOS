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
        
        let chatDialogRepository = ChatDialogRepository()
        let chatService = QuickBloxChatService(chatAuthService: QuickBloxChatAuthService(),
                                               chatDialogService:
                                                QuickBloxChatDialogService(chatDialogRepository: chatDialogRepository))
        chatService.login(email: "random@random.sg", password: "asfsdfsff")
    }
    
    func checkIfUserLoggedIn() -> Bool {
        userState.loggedIn
    }
}
