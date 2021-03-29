//
//  GuidesListingModule.swift
//  Challo
//
//  Created by Kester Ng on 21/3/21.
//

import SwiftUI

final class GuidesListingModule: ViperModuleProtocol {
    
    let guideRepository: GuideRepositoryProtocol
    let reviewAPI: ReviewAPIProtocol

    init(guideRepository: GuideRepositoryProtocol, reviewAPI: ReviewAPIProtocol) {
        self.guideRepository = guideRepository
        self.reviewAPI = reviewAPI
    }
    
    func assemble() -> (view: AnyView, presenter: GuidesListingPresenter) {        
        let interactor = GuidesListingInteractor(guideRepository: guideRepository)
        let router = GuidesListingRouter(reviewAPI: reviewAPI)
        let presenter = GuidesListingPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        presenter.interactor.populateGuides()
        return (AnyView(GuidesListingPage(presenter: presenter)), presenter: presenter)
    }
}
