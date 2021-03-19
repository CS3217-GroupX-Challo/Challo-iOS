//
//  TouristRegisterModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import SwiftUI

final class TouristRegisterModule: ViperModuleProtocol {

    static func assemble() -> (view: AnyView, presenter: TouristRegisterPresenter) {
        let interactor = TouristRegisterInteractor()
        let presenter = TouristRegisterPresenter()
        let router = TouristRegisterRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        let (_, loginPresenter) = TouristLoginModule.assemble()
        let registerView = AnyView(TouristRegisterPage(loginPresenter: loginPresenter, registerPresenter: presenter))
        return (view: registerView, presenter: presenter)
    }
}
