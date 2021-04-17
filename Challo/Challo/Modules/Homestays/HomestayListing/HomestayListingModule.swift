//
//  HomestayListingModule.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

final class HomestayListingModule: ViperModuleProtocol {
    let homestayRepository: HomestayRepositoryProtocol

    init(homestayRepository: HomestayRepositoryProtocol) {
        self.homestayRepository = homestayRepository
    }
    
    func assemble() -> (view: AnyView, presenter: HomestayListingPresenter) {
        let interactor = HomestayListingInteractor(homestayRepository: homestayRepository)
        let router = HomestayListingRouter()
        let presenter = HomestayListingPresenter()
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter
        return (AnyView(EmptyView()), presenter: presenter)
    }
}
