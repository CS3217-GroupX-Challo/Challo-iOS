//
//  TouristLoginModule.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//
import SwiftUI

final class TouristLoginModule: ViperModuleProtocol {

    static func assemble(userState: UserStateProtocol) -> (view: AnyView, presenter: TouristLoginPresenter) {
        let interactor = TouristLoginInteractor()
        let presenter = TouristLoginPresenter()
        let router = TouristLoginRouter(userState: userState)
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        router.presenter = presenter

        let loginAPI = TouristLoginAPI()
        let registerAPI = TouristRegistrationAPI()
        let socialPresenter = SocialLoginPresenter
            .createSocialLoginPresenter(loginAPI: loginAPI, registerAPI: registerAPI)

        return (view: AnyView(TouristLoginPage(loginPresenter: presenter, socialLoginPresenter: socialPresenter)),
                presenter: presenter)
    }
}
