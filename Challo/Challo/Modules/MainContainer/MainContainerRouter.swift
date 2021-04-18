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
    var apiContainer: APIContainer
    var repositoryContainer: RepositoryContainer
    var profilePage: AnyView!
    var loginPage: AnyView!
    var settingsPage: AnyView!
    var chatPage: AnyView!
    #if TOURIST
    var trailsPage: AnyView!
    var guidesPage: AnyView!
    var mapsPage: AnyView!
    var homestayPage: AnyView!
    #endif
    
    init(userState: UserStateProtocol) {
        self.userState = userState
        apiContainer = APIContainer(userState: userState)
        repositoryContainer = RepositoryContainer(apiContainer: apiContainer)
        #if TOURIST
        trailsPage = TrailListingModule(trailRepository: resolveTrailRepository(),
                                        guideRepository: resolveGuideRepository(),
                                        bookingRepository: resolveBookingRepository(),
                                        bookingAPI: resolveBookingAPI(),
                                        reviewAPI: resolveReviewAPI(),
                                        userState: userState).assemble().view
        guidesPage = GuidesListingModule(guideRepository: resolveGuideRepository(),
                                         reviewAPI: resolveReviewAPI()).assemble().view
        mapsPage = MapModule(placesAPI: resolvePlacesAPI()).assemble().view
        #endif
        settingsPage = SettingsModule(userState: userState,
                                      loginAPI: resolveTouristLoginAPI(),
                                      registerAPI: resolveTouristRegisterAPI()).assemble().view
        setUpLoginAndProfile(bookingRepository: resolveBookingRepository(),
                             reviewAPI: resolveReviewAPI(),
                             userState: userState)
    }

    private func setUpAndReturnChatService() -> ChatService {
        let chatDialogRepository = ChatDialogRepository()
        let chatService = QuickBloxChatService(chatAuthService: QuickBloxChatAuthService(),
                                               chatDialogService: QuickBloxChatDialogService(chatDialogRepository:
                                                                                                chatDialogRepository))
        chatPage = ChatModule(chatService: chatService, userState: userState).assemble().view
        return chatService
    }

    #if TOURIST
    private func setupChatProfileHomestayPage(bookingRepository: BookingRepositoryProtocol,
                                              reviewAPI: ReviewAPIProtocol,
                                              userAPI: UserAPIProtocol) {
        let chatDialogRepository = ChatDialogRepository()
        let chatService = QuickBloxChatService(chatAuthService: QuickBloxChatAuthService(),
                                               chatDialogService: QuickBloxChatDialogService(chatDialogRepository:
                                                                                                chatDialogRepository))
        chatPage = ChatModule(chatService: chatService, userState: userState).assemble().view
        
        profilePage = TouristDashboardModule(userState: userState, bookingRepository: bookingRepository,
                                             reviewAPI: reviewAPI,
                                             sendMessageToGuide: { [weak self] guideEmail, _, messageText in
                                                self?.sendMessageToUser(userEmail: guideEmail,
                                                                        messageText: messageText,
                                                                        chatService: chatService)
                                             },
                                             updateUserChat: { [weak self] name, email in
                                                self?.updateUser(name: name, email: email, chatService: chatService)
                                             },
                                             userAPI: userAPI).assemble().view
        
        homestayPage = HomestayListingModule(userState: userState,
                                             homestayRepository: resolveHomestayRepository(),
                                             sendMessageToHost: { [weak self] hostEmail, messageText in
                                                self?.sendMessageToUser(userEmail: hostEmail,
                                                                        messageText: messageText,
                                                                        chatService: chatService)
                                             }).assemble().view
    }
    #endif
    
    private func setUpLoginAndProfile(bookingRepository: BookingRepositoryProtocol,
                                      reviewAPI: ReviewAPIProtocol,
                                      userState: UserStateProtocol) {

        let chatService = setUpAndReturnChatService()
        let userAPI = resolveUserAPI()

        #if GUIDE
        loginPage = GuideLoginModule(userState: userState,
                                     loginAPI: resolveGuideLoginAPI(),
                                     registerAPI: resolveGuideRegisterAPI()).assemble().view
        profilePage = GuideDashboardModule(userState: userState,
                                           bookingRepository: bookingRepository,
                                           sendMessageToTourist: { [weak self] touristEmail, _, messageText in
                                            self?.sendMessageToUser(userEmail: touristEmail,
                                                                    messageText: messageText,
                                                                    chatService: chatService)
                                           },
                                           updateUserChat: { [weak self] name, email in
                                            self?.updateUser(name: name, email: email, chatService: chatService)
                                           },
                                           userAPI: userAPI).assemble().view

        #elseif TOURIST
        loginPage = TouristLoginModule(userState: userState,
                                       loginAPI: resolveTouristLoginAPI(),
                                       registerAPI: resolveTouristRegisterAPI()).assemble().view
        setupChatProfileHomestayPage(bookingRepository: bookingRepository,
                                     reviewAPI: reviewAPI,
                                     userAPI: userAPI)
        #endif
    }
}

// MARK: Dependency Resolve
extension MainContainerRouter {
    private func resolveTrailRepository() -> TrailRepositoryProtocol {
        guard let trailRepository = repositoryContainer.container.resolve(TrailRepositoryProtocol.self) else {
            fatalError("Failed to resolve trailRepository in MainContainer")
        }
        return trailRepository
    }
    
    private func resolveGuideRepository() -> GuideRepositoryProtocol {
        guard let guideRepository = repositoryContainer.container.resolve(GuideRepositoryProtocol.self) else {
            fatalError("Failed to resolve guideRepository in MainContainer")
        }
        return guideRepository
    }
    
    private func resolveBookingRepository() -> BookingRepositoryProtocol {
        guard let bookingRepository = repositoryContainer.container.resolve(BookingRepositoryProtocol.self) else {
            fatalError("Failed to resolve bookingAPI in MainContainer")
        }
        return bookingRepository
    }
    
    private func resolveHomestayRepository() -> HomestayRepositoryProtocol {
        guard let homestayRepository = repositoryContainer.container.resolve(HomestayRepositoryProtocol.self) else {
            fatalError("Failed to resolve homestayRepository in MainContainer")
        }
        return homestayRepository
    }
    
    private func resolveReviewAPI() -> ReviewAPIProtocol {
        guard let reviewAPI = apiContainer.container.resolve(ReviewAPIProtocol.self) else {
            fatalError("Failed to resolve reviewAPI in MainContainer")
        }
        return reviewAPI
    }
    
    private func resolveBookingAPI() -> BookingAPIProtocol {
        guard let bookingAPI = apiContainer.container.resolve(BookingAPIProtocol.self) else {
            fatalError("Failed to resolve bookingAPI in MainContainer")
        }
        return bookingAPI
    }
    
    private func resolvePlacesAPI() -> PlacesAPIProtocol {
        guard let placesAPI = apiContainer.container.resolve(PlacesAPIProtocol.self) else {
            fatalError("Failed to resolve placesAPI in MainContainer")
        }
        return placesAPI
    }
    
    private func resolveUserAPI() -> UserAPIProtocol {
        guard let userAPI = apiContainer.container.resolve(UserAPIProtocol.self) else {
            fatalError("Failed to resolve userAPI in MainContainer")
        }
        return userAPI
    }
    
    private func resolveTouristLoginAPI() -> LoginAPI {
        guard let touristLoginAPI = apiContainer.container.resolve(LoginAPI.self,
                                                                   name: ContainerNames.tourist.rawValue) else {
            fatalError("Failed to resolve touristLoginAPI in MainContainer")
        }
        return touristLoginAPI
    }
    
    private func resolveGuideLoginAPI() -> LoginAPI {
        guard let guideLoginAPI = apiContainer.container.resolve(LoginAPI.self,
                                                                 name: ContainerNames.guide.rawValue) else {
            fatalError("Failed to resolve touristLoginAPI in MainContainer")
        }
        return guideLoginAPI
    }

    private func resolveTouristRegisterAPI() -> RegisterAPI {
        guard let touristRegisterAPI = apiContainer.container.resolve(RegisterAPI.self,
                                                                      name: ContainerNames.tourist.rawValue) else {
            fatalError("Failed to resolve touristRegisterAPI in MainContainer")
        }
        return touristRegisterAPI
    }

    private func resolveGuideRegisterAPI() -> RegisterAPI {
        guard let guideRegisterAPI = apiContainer.container.resolve(RegisterAPI.self,
                                                                    name: ContainerNames.guide.rawValue) else {
            fatalError("Failed to resolve touristRegisterAPI in MainContainer")
        }
        return guideRegisterAPI
    }
}

// MARK: Cross Module Chat Logic
extension MainContainerRouter {
    private func connectThenOp(chatService: ChatService, didConnect: @escaping (() -> Void)) {
        guard let chatUserId = chatService.chatUserId else {
            fatalError("Attempting to connect when not logged in")
        }
        chatService.connectToChatServer(chatUserId: chatUserId,
                                        password: userState.userId) { _, isSuccessful in
            guard isSuccessful else {
                return
            }
            didConnect()
        }
    }

    private func sendMessageToUser(userEmail: String, messageText: String, chatService: ChatService,
                                   didSendMessage: @escaping (() -> Void)) {
        guard let dialog = chatService.getDialogWithChateeEmail(userEmail) else {
            chatService.createPrivateDialog(with: userEmail) { dialog in
                chatService.sendMessage(messageBody: messageText,
                                        dialogId: dialog.dialogId,
                                        willSendMessage: nil) { _, _ in
                    didSendMessage()
                }
            }
            return
        }
        chatService.sendMessage(messageBody: messageText,
                                dialogId: dialog.dialogId)
    }
    
    private func sendMessageToUser(userEmail: String, messageText: String, chatService: ChatService) {
        let didSendMessage: (() -> Void) = { [weak self] in
            self?.presenter.goToChatPage()
        }
        guard !chatService.isConnected else {
            sendMessageToUser(userEmail: userEmail, messageText: messageText, chatService: chatService,
                              didSendMessage: didSendMessage)
            return
        }
        connectThenOp(chatService: chatService) { [weak self] in
            self?.sendMessageToUser(userEmail: userEmail, messageText: messageText, chatService: chatService,
                                    didSendMessage: didSendMessage)
        }
    }
    
    private func updateUser(name: String, email: String, chatService: ChatService) {
        chatService.updateUser(name: name, email: email)
    }

    private func checkConnectAndUpdateUser(name: String, email: String, chatService: ChatService) {
        guard !chatService.isConnected else {
            updateUser(name: name, email: email, chatService: chatService)
            return
        }
        connectThenOp(chatService: chatService) { [weak self] in
            self?.updateUser(name: name, email: email, chatService: chatService)
        }
    }

}
