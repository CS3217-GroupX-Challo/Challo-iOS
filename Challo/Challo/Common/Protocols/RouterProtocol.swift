//
//  RouterProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

protocol RouterProtocol: AnyObject {
    associatedtype PresenterProtocol

    var presenter: PresenterProtocol! { get set }
}
