//
//  TouristLoginInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristLoginInteractor: LoginInteractor, InteractorProtocol {

    let networkManager = AlamofireManager.alamofireManager
    let facebookLoginService: FacebookLoginService = FacebookLoginService()
    weak var presenter: LoginPresenter!
}
