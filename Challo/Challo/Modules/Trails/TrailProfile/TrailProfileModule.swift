//
//  TrailProfileModule.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfileModule: ViperModuleProtocol {
    var reviewAPI: ReviewAPIProtocol
    
    init(reviewAPI: ReviewAPIProtocol) {
        self.reviewAPI = reviewAPI
    }
    
    func assemble() -> (view: AnyView, presenter: TrailProfilePresenter) {
        let interactor = TrailProfileInteractor(reviewAPI: reviewAPI)
        let presenter = TrailProfilePresenter()
        let router = TrailProfileRouter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (view: AnyView(TrailProfilePage().environmentObject(presenter)), presenter: presenter)
    }
}
