//
//  TrailProfileRouter.swift
//  Challo
//
//  Created by Shao Yi on 20/3/21.
//

import SwiftUI

class TrailProfileRouter: RouterProtocol {
    
    weak var presenter: TrailProfilePresenter!

    func getBookingPage() -> some View {
        TrailBookingPage()
            .environmentObject(presenter)
    }
}
