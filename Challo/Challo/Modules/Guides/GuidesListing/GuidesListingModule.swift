//
//  GuidesListingModule.swift
//  Challo
//
//  Created by Kester Ng on 21/3/21.
//

import SwiftUI

final class GuidesListingModule: ViperModuleProtocol {
    static func assemble() -> (view: AnyView, presenter: GuidesListingPresenter) {
        let guideAPI = GuideAPI(guideParser: GuideAPIParser(),
                                trailParser: TrailAPIParser(),
                                networkManager: APINetwork.getNetworkManager())
        let areaAPI = AreaAPI(areaParser: AreaAPIParser(),
                              networkManager: APINetwork.getNetworkManager())
        
        let interactor = GuidesListingInteractor(guideAPI: guideAPI,
                                                 areaAPI: areaAPI)
        let router = GuidesListingRouter()
        let presenter = GuidesListingPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.interactor.populateGuides()
        return (AnyView(GuidesListingPage(presenter: presenter)), presenter: presenter)
    }
}
