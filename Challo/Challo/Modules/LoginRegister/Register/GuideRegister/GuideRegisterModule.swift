//
//  GuideRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import SwiftUI

class GuideRegisterModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: GuideRegisterPresenter) {
        let interactor = GuideRegisterInteractor()
        let presenter = GuideRegisterPresenter()
        let router = GuideRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        let (_, loginPresenter) = GuideLoginModule.assemble()
        let registerView = AnyView(GuideRegisterPage(loginPresenter: loginPresenter, registerPresenter: presenter))
        return (view: registerView, presenter: presenter)
    }
}
