//
//  ProfilableEntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

protocol ProfilableEntityListingPresenter: EntityListingPresenter where Router: ProfilableEntityListingRouter,
                                                                        Router.Entity == Entity {
    associatedtype Entity

    var profilePage: AnyView? { get }

    func onTapListingCard(_ cardId: String)

}

extension ProfilableEntityListingPresenter {
    var profilePage: AnyView? {
        router?.profilePage
    }
    
    func onTapListingCard(_ cardId: String) {
        let entity = getEntityByCardId(cardId)
        router?.populateProfilePage(entity)
    }
}
