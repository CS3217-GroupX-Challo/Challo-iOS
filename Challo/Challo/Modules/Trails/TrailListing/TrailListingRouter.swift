//
//  TrailListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingRouter: RouterProtocol {
    
    weak var presenter: TrailListingPresenter!
    let userState: UserStateProtocol
    var trailProfilePage: AnyView
    var trailProfilePresenter: TrailProfilePresenter
    
    init(userState: UserStateProtocol) {
        self.userState = userState
        let (view, presenter) = TrailProfileModule.assemble(userState: userState)
        trailProfilePage = view
        trailProfilePresenter = presenter
    }
    
    func populateTrailProfilePageFor(trail: Trail) {
        trailProfilePresenter.populateTrailProfilePageFor(trail: trail)
    }
    
}
