//
//  EntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

protocol EntityListingPresenter: SearchBarPresenter where Router: EntityListingRouter,
                                                          Router.Entity == Entity,
                                                          Interactor: EntityListingInteractor,
                                                          Interactor.Entity == Entity {
    associatedtype Entity
    
    var router: Router? { get set }
    var interactor: Interactor! { get set }
    
    var isLoading: Bool { get set }
    var isRefreshing: Bool { get set }
    var displayedCards: [ListingCard] { get }
    
    var profilePage: AnyView? { get }
    
    func getEntityByCardId(_ cardId: String) -> Entity
    func onTapListingCard(_ cardId: String) 
}

extension EntityListingPresenter {
    var profilePage: AnyView? {
        router?.profilePage
    }
    
    func onTapListingCard(_ cardId: String) {
        let entity = getEntityByCardId(cardId)
        router?.populateProfilePage(entity)
    }
}
