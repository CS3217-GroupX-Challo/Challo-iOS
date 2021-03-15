//
//  InteractorProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

protocol InteractorProtocol: AnyObject {
    associatedtype PresenterProtocol

    var presenter: PresenterProtocol! { get set }
}
