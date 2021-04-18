//
//  EntityProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

/// A generic presenter that encapsulates common presentation logic for displaying the profile of an entity
protocol EntityProfilePresenter: PresenterProtocol where Interactor: EntityProfileInteractor,
                                                         Interactor.Entity == Entity {
    associatedtype Entity: ImageableEntity
    
    var isUserLoggedIn: Bool { get }
    var isShowingNotLoggedInAlert: Bool { get set }
    var canUserClickCTA: Bool { get }
    
    var currentEntity: Entity? { get set }
    var currentEntityImage: String? { get }
    
    func populateProfilePage(_ entity: Entity)
}

extension EntityProfilePresenter {
    var isUserLoggedIn: Bool {
        interactor.userState.loggedIn
    }
    
    var canUserClickCTA: Bool {
        isUserLoggedIn
    }
    
    var currentEntityImage: String? {
        guard let entity = currentEntity, !entity.images.isEmpty else {
            return nil
        }
        return entity.images[0]
    }
    
    func onTapBookCTAButton() {
        if isUserLoggedIn {
            return
        }
        isShowingNotLoggedInAlert = true
    }
}
