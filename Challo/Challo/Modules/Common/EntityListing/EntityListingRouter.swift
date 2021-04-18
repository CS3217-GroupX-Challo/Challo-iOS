//
//  EntityListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

protocol EntityListingRouter: RouterProtocol where Presenter: EntityListingPresenter {
    associatedtype Entity
    
    var profilePage: AnyView { get set }
    
    func populateProfilePage(_ entity: Entity)
}
