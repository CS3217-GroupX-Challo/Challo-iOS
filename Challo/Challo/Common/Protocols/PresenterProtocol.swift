//
//  PresenterProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Combine

protocol PresenterProtocol: ObservableObject {
    associatedtype InteractorProtocol
    associatedtype RouterProtocol

    var router: RouterProtocol? { get set }
    var interactor: InteractorProtocol! { get set }
}
