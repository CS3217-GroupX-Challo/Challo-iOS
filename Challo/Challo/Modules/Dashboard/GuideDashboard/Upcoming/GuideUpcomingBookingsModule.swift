//
//  GuideUpcomingBookingsModule.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation
import SwiftUI

class GuideUpcomingBookingsModule: ViperModuleProtocol {

    func assemble() -> (view: AnyView, presenter: GuideUpcomingBookingsPresenter) {
        (AnyView(Text("Placeholder")), GuideUpcomingBookingsPresenter())
    }
}
