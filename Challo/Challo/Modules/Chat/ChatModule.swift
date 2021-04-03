//
//  ChatModule.swift
//  Challo
//
//  Created by Shao Yi on 2/4/21.
//

import SwiftUI

class ChatModule: ViperModuleProtocol {
    
    let chatService: ChatService
    let userState: UserStateProtocol
    
    init(chatService: ChatService, userState: UserStateProtocol) {
        self.chatService = chatService
        self.userState = userState
    }
    
    func assemble() -> (view: AnyView, presenter: ChatPresenter) {
        let interactor = ChatInteractor(chatService: chatService, userState: userState)
        let router = ChatRouter()
        let presenter = ChatPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(ChatView().environmentObject(presenter)), presenter: presenter)
    }
}
