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

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

}
