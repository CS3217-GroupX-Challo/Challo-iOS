//
//  EntityProfileInteractor.swift
//  Challo
//
//  Created by Shao Yi on 18/4/21.
//

protocol EntityProfileInteractor: InteractorProtocol {
    associatedtype Entity
    
    var userState: UserStateProtocol { get }
    
}
