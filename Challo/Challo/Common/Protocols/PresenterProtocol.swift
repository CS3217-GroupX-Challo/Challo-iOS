//
//  PresenterProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import Combine

/// Presenter in a VIPER module
///
/// This component is responsible for all presentation logic of the module
protocol PresenterProtocol: ObservableObject {
    associatedtype Interactor: InteractorProtocol
    associatedtype Router: RouterProtocol

    var router: Router? { get set }
    var interactor: Interactor! { get set }
}
