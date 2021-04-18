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
    
    var profilePage: AnyView
    var homestayProfilePresenter: HomestayProfilePresenter
    
    init(userState: UserStateProtocol, homestayRepository: HomestayRepositoryProtocol) {
        let (view, presenter) = HomestayProfileModule(userState: userState,
                                                      homestayRepository: homestayRepository).assemble()
        profilePage = view
        homestayProfilePresenter = presenter
    }
    
    func populateProfilePage(_ entity: Homestay) {
        homestayProfilePresenter.populateProfilePage(entity)
    }

}
