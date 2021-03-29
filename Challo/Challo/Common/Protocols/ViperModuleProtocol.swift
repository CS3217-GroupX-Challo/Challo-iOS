//
//  ViperModuleProtocol.swift
//  Challo
//
//  Created by Shao Yi on 15/3/21.
//

import SwiftUI

/// Assembler component of a VIPER module
///
/// This component is responsible for assembling all components in a VIPER module
protocol ViperModuleProtocol {
    associatedtype Presenter: PresenterProtocol

    static func assemble(userState: UserStateProtocol) -> (view: AnyView, presenter: Presenter)
}
