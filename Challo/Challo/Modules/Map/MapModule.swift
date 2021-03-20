//
//  MapModule.swift
//  Challo
//
//  Created by Kester Ng on 20/3/21.
//

import SwiftUI

final class MapModule: ViperModuleProtocol {
    static func assemble() -> (view: AnyView, presenter: MapPresenter) {
        let interactor = MapInteractor()
        let router = MapRouter()
        let presenter = MapPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(InteractiveMapPage()), presenter: presenter)
    }
}
