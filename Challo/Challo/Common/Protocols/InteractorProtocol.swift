//
//  InteractorProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

/// Interactor in a VIPER module
///
/// This component is responsible for all domain logic of the module
protocol InteractorProtocol: AnyObject {
    associatedtype Presenter: PresenterProtocol

    var presenter: Presenter! { get set }
}
