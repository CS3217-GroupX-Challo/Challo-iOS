//
//  HomestayProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

class HomestayProfilePresenter: EntityProfilePresenter, AlertPresenter, ObservableObject {

    var interactor: HomestayProfileInteractor!
    var router: HomestayProfileRouter?

    @Published var isShowingNotLoggedInAlert = false
    @Published var isChatSheetOpen = false
    @Published var chatMessageText = ""
    
    @Published var isSuccessAlert: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

    var currentEntity: Homestay?
    
    func populateProfilePage(_ entity: Homestay) {
        currentEntity = entity
    }
    
    func onTapSendMessage() {
        guard !chatMessageText.isEmpty else {
            return
        }
        
        defer {
            chatMessageText = ""
        }
        
        let alertTitle = "Chat with Host"
        guard let host = currentEntity?.host else {
            ChalloLogger.logger.error("Attempting to send message to homestay without host")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.presentFailureAlert(title: alertTitle, message: "Your message could not be sent")
            }
            return
        }
        interactor.sendMessageToHost(host.email, chatMessageText)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.presentSuccessAlert(title: alertTitle, message: "Your message has been sent!")
        }
    }
}
