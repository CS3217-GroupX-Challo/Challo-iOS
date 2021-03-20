//
//  TrailListingRouter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingRouter: RouterProtocol {
    
    weak var presenter: TrailListingPresenter!
    var trailProfilePage: AnyView
    var trailProfilePresenter: TrailProfilePresenter
    
    init() {
        let (view, presenter) = TrailProfileModule.assemble()
        trailProfilePage = view
        trailProfilePresenter = presenter
    }
    
    func populateTrailProfilePageFor(trail: Trail) {
        trailProfilePresenter.populateTrailProfilePageFor(trail: trail)
    }
    
}
