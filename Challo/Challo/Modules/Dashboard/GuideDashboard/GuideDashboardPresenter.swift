//
//  GuideDashboardPresenter.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideDashboardPresenter: PresenterProtocol {

    var router: GuideDashboardRouter?
    var interactor: GuideDashboardInteractor!

    unowned let userState: UserStateProtocol!

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    func refresh() {
        
    }

}
