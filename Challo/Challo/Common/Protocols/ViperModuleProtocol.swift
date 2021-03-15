//
//  ViperModuleProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import SwiftUI

protocol ViperModuleProtocol {
    associatedtype Presenter: PresenterProtocol

    static func assemble() -> (view: AnyView, presenter: Presenter)
}
