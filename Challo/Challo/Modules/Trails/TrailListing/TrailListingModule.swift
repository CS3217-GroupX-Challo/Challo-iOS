//
//  TrailListingModule.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingModule: ViperModuleProtocol {

    static func assemble(userState: UserStateProtocol) -> (view: AnyView, presenter: TrailListingPresenter) {
        let interactor = TrailListingInteractor()
        let presenter = TrailListingPresenter()
        let router = TrailListingRouter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.getAllTrails()
        return (view: AnyView(TrailListingPage().environmentObject(presenter)), presenter: presenter)
    }
}
