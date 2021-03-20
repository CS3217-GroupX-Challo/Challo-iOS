//
//  TrailProfilePresenter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfilePresenter: PresenterProtocol, ObservableObject {

    var interactor: TrailProfileInteractor!
    var router: TrailProfileRouter?

    @Published var currentTrail: Trail? = nil
    
    func populateTrailProfilePageFor(trail: Trail) {
        currentTrail = trail
    }
}
