//
//  EntityListingPresenter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

protocol EntityListingPresenter: SearchBarPresenter where Interactor: EntityListingInteractor {
    var isLoading: Bool { get set }
    var isRefreshing: Bool { get set }
    var displayedCards: [ListingCard] { get }
    
    var profilePage: AnyView? { get }
    
    func onTapListingCard(_ cardId: String) 
}
