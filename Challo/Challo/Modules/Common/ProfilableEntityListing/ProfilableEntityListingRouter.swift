//
//  ProfilableEntityListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

import SwiftUI

protocol ProfilableEntityListingRouter: RouterProtocol where Presenter: ProfilableEntityListingPresenter {
    associatedtype Entity
    
    var profilePage: AnyView { get set }
    
    func populateProfilePage(_ entity: Entity)
}
