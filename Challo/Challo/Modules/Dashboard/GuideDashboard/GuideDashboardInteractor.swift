//
//  GuideDashboardInteractor.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation

class GuideDashboardInteractor: InteractorProtocol {
    weak var presenter: GuideDashboardPresenter!

    let userState: UserStateProtocol
    let userAPI: UserAPIProtocol
    let updateUserChat: ((_ name: String, _ email: String) -> Void)

    init(userState: UserStateProtocol, userAPI: UserAPIProtocol,
         updateUserChat: @escaping ((_ name: String, _ email: String) -> Void)) {
        self.userState = userState
        self.userAPI = userAPI
        self.updateUserChat = updateUserChat
    }

}

extension GuideDashboardInteractor: ProfileUpdaterInteractor { }
