//
//  HomestayListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

class HomestayListingRouter: EntityListingRouter {
    
    typealias Entity = Homestay
    
    weak var presenter: HomestayListingPresenter!
    
    var profilePage = AnyView(EmptyView())
    
    func populateProfilePage(_ entity: Homestay) {
    }

}
