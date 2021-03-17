//
//  GuidesModule.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//
import SwiftUI

final class GuidesModule: ViperModuleProtocol {
    static func assemble() -> (view: AnyView, presenter: GuidesListingPresenter) {
        let interactor = GuidesListingInteractor()
        let router = GuidesListingRouter()
        let presenter = GuidesListingPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(GuidesListingPage(presenter: presenter)), presenter: presenter)
    }
}
