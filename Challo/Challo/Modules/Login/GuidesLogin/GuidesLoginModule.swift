//
//  GuidesLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class GuidesLoginModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: GuidesLoginPresenter) {
        let interactor = GuidesLoginInteractor()
        let presenter = GuidesLoginPresenter()
        let router = GuidesLoginRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(GuidesLoginPage(loginPresenter: presenter)), presenter: presenter)
    }
}
