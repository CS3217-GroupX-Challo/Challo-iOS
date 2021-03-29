//
//  MainContainerModule.swift
//  Challo
//
//  Created by Shao Yi on 19/3/21.
//

import SwiftUI

class MainContainerModule: ViperModuleProtocol {
    func assemble() -> (view: AnyView, presenter: MainContainerPresenter) {
        let interactor = MainContainerInteractor()
        let presenter = MainContainerPresenter()
        let router = MainContainerRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(MainContainerView().environmentObject(presenter)), presenter: presenter)
    }
}
