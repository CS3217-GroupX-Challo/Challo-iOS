//
//  EntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

/// A generic presenter that encapsulates common presentation logic for displaying entity listings
protocol EntityListingPresenter: PresenterProtocol where Router: EntityListingRouter,
                                                         Router.Entity == Entity,
                                                         Interactor: EntityListingInteractor,
                                                         Interactor.Entity == Entity {
    associatedtype Entity
    
    var router: Router? { get set }
    var interactor: Interactor! { get set }
    
    var entities: [Entity] { get set }
    
    var isFirstLoad: Bool { get set }
    var isLoading: Bool { get set }
    var isRefreshing: Bool { get set }
    var displayedCards: [ListingCard] { get }
    var profilePage: AnyView? { get }
    
    func getAllEntities()
    func getEntityByCardId(_ cardId: String) -> Entity
    func onTapListingCard(_ cardId: String)
    func onPageAppear()
}

extension EntityListingPresenter {
    var profilePage: AnyView? {
        router?.profilePage
    }
    
    func onTapListingCard(_ cardId: String) {
        let entity = getEntityByCardId(cardId)
        router?.populateProfilePage(entity)
    }
    
    func didGetAllEntities(_ entities: [Entity]) {
        self.entities = entities
        isLoading = false
        isRefreshing = false
    }
    
    func getAllEntities() {
        interactor.getAllEntities()
    }
    
    func onPageAppear() {
        self.entities = interactor.getCachedEntities()
        if isFirstLoad {
            isLoading = true
            getAllEntities()
            isFirstLoad = false
        }
    }
}
