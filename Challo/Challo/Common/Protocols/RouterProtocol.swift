//
//  RouterProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

/// Router in a VIPER module
///
/// This component is responsible for all navigational logic of the module
protocol RouterProtocol: AnyObject {
    associatedtype PresenterProtocol

    var presenter: PresenterProtocol! { get set }
}
