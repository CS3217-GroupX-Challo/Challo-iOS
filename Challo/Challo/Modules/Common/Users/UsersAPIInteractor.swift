//
//  UserAPIInteractor.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

protocol UsersAPIInteractor {
    func getUser(api: AlamofireManager, url: String) -> User
}

extension UsersAPIInteractor {
}
