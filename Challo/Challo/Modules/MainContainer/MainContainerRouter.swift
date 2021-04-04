//
//  MainContainerRouter.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerRouter: RouterProtocol {
    
    weak var presenter: MainContainerPresenter!
    let userState: UserStateProtocol
    var apiContainer = APIContainer()
    var repositoryContainer: RepositoryContainer
    var profilePage: AnyView!
    var trailsPage: AnyView
    var guidesPage: AnyView
    var mapsPage: AnyView
    var settingsPage: AnyView
    var loginPage: AnyView
    var homePage: AnyView
    var chatPage: AnyView!
    
    init(userState: UserStateProtocol) {
        self.userState = userState
        repositoryContainer = RepositoryContainer(apiContainer: apiContainer)
        
        guard let trailRepository = repositoryContainer.container.resolve(TrailRepositoryProtocol.self) else {
            fatalError("Failed to resolve trailRepository in MainContainer")
        }
        guard let guideRepository = repositoryContainer.container.resolve(GuideRepositoryProtocol.self) else {
            fatalError("Failed to resolve guideRepository in MainContainer")
        }
        guard let bookingRepository = repositoryContainer.container.resolve(BookingRepositoryProtocol.self) else {
            fatalError("Failed to resolve bookingAPI in MainContainer")
        }
        guard let reviewAPI = apiContainer.container.resolve(ReviewAPIProtocol.self) else {
            fatalError("Failed to resolve reviewAPI in MainContainer")
        }
        guard let bookingAPI = apiContainer.container.resolve(BookingAPIProtocol.self) else {
            fatalError("Failed to resolve bookingAPI in MainContainer")
        }
        guard let placesAPI = apiContainer.container.resolve(PlacesAPIProtocol.self) else {
            fatalError("Failed to resolve placesAPI in MainContainer")
        }

        homePage = AnyView(Text("Homepage"))
        loginPage = TouristLoginModule(userState: userState).assemble().view
        trailsPage = TrailListingModule(trailRepository: trailRepository,
                                        guideRepository: guideRepository,
                                        bookingAPI: bookingAPI,
                                        reviewAPI: reviewAPI,
                                        userState: userState).assemble().view
        guidesPage = GuidesListingModule(guideRepository: guideRepository, reviewAPI: reviewAPI).assemble().view
        mapsPage = MapModule(placesAPI: placesAPI).assemble().view
        settingsPage = SettingsModule(userState: userState).assemble().view
        setupChatAndProfilePage(bookingRepository)
    }
    
    private func setupChatAndProfilePage(_ bookingRepository: BookingRepositoryProtocol) {
        let chatDialogRepository = ChatDialogRepository()
        let chatService = QuickBloxChatService(chatAuthService: QuickBloxChatAuthService(),
                                               chatDialogService: QuickBloxChatDialogService(chatDialogRepository:
                                                                                                chatDialogRepository))
        chatPage = ChatModule(chatService: chatService, userState: userState).assemble().view
        
        profilePage = TouristDashboardModule(userState: userState, bookingsRepository: bookingRepository,
                                             sendMessageToGuide: { [weak self] guideEmail, _, messageText in
                                                self?.sendMessageToGuide(guideEmail: guideEmail,
                                                                         messageText: messageText,
                                                                         chatService: chatService)
                                             }).assemble().view
    }
    
    private func sendMessageToGuideAfterConnected(guideEmail: String, messageText: String, chatService: ChatService) {
        guard let dialog = chatService.getDialogWithChateeEmail(guideEmail) else {
            chatService.createPrivateDialog(with: guideEmail) { dialog in
                chatService.sendMessage(messageBody: messageText,
                                        dialogId: dialog.dialogId)
            }
            return
        }
        chatService.sendMessage(messageBody: messageText,
                                dialogId: dialog.dialogId)
    }
    
    private func connectThenSend(guideEmail: String, messageText: String, chatService: ChatService) {
        guard let chatUserId = chatService.chatUserId else {
            fatalError("Attempting to connect when not logged in")
        }
        chatService.connectToChatServer(chatUserId: chatUserId,
                                        password: userState.userId) { [weak self] _, isSuccessful in
            guard isSuccessful else {
                return
            }
            self?.sendMessageToGuideAfterConnected(guideEmail: guideEmail, messageText: messageText,
                                                   chatService: chatService)
        }
    }
    
    private func sendMessageToGuide(guideEmail: String, messageText: String, chatService: ChatService) {
        defer {
            presenter.goToChatPage()
        }
        guard !chatService.isConnected else {
            sendMessageToGuideAfterConnected(guideEmail: guideEmail, messageText: messageText, chatService: chatService)
            return
        }
        connectThenSend(guideEmail: guideEmail, messageText: messageText, chatService: chatService)
    }

}
