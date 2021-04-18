//
//  EntityProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

protocol EntityProfilePresenter: PresenterProtocol {
    associatedtype Entity: ImageableEntity
    
    var userState: UserStateProtocol { get }
    var isShowingNotLoggedInAlert: Bool { get set }
    
    var currentEntity: Entity? { get set }
    var currentEntityImage: String? { get }
    
    func populateProfilePage(_ entity: Entity)
}

extension EntityProfilePresenter {
    var currentEntityImage: String? {
        guard let entity = currentEntity, !entity.images.isEmpty else {
            return nil
        }
        return entity.images[0]
    }
    
    func onTapBookCTAButton() {
        if userState.loggedIn {
            return
        }
        isShowingNotLoggedInAlert = true
    }
}
