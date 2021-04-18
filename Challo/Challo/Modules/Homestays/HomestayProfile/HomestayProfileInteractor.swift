//
//  HomestayProfileInteractor.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

class HomestayProfileInteractor: EntityProfileInteractor {

    typealias Entity = Homestay
    
    var userState: UserStateProtocol
    weak var presenter: HomestayProfilePresenter!
    let sendMessageToHost: ((_ hostEmail: String, _ messageText: String) -> Void)

    init(userState: UserStateProtocol,
         sendMessageToHost: @escaping ((_ hostEmail: String, _ messageText: String) -> Void)) {
        self.userState = userState
        self.sendMessageToHost = sendMessageToHost
    }

}
