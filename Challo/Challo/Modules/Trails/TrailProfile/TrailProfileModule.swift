//
//  TrailProfileModule.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfileModule: ViperModuleProtocol {
    static func assemble() -> (view: AnyView, presenter: TrailProfilePresenter) {
        let interactor = TrailProfileInteractor()
        let presenter = TrailProfilePresenter()
        let router = TrailProfileRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailProfilePage().environmentObject(presenter)), presenter: presenter)
    }
}
