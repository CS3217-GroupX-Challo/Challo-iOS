//
//  TrailListingModule.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailListingModule: ViperModuleProtocol {
    
    let trailRepository: TrailRepositoryProtocol
    let reviewAPI: ReviewAPIProtocol
    
    init(trailRepository: TrailRepositoryProtocol, reviewAPI: ReviewAPIProtocol, userState: UserStateProtocol) {
        self.trailRepository = trailRepository
        self.reviewAPI = reviewAPI
    }
    
    func assemble() -> (view: AnyView, presenter: TrailListingPresenter) {
        let interactor = TrailListingInteractor(trailRepository: trailRepository)
        let presenter = TrailListingPresenter()
        let router = TrailListingRouter(reviewAPI: reviewAPI)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailListingPage().environmentObject(presenter)), presenter: presenter)
    }
}
