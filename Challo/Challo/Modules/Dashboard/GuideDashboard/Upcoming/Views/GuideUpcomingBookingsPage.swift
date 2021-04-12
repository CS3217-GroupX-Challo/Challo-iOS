//
//  GuideUpcomingBookingsPage.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import SwiftUI

struct GuideUpcomingBookingsPage: View {

    var presenter: GuideUpcomingBookingsPresenter

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Header(title: presenter.name,
                       subtitle: "Your upcoming bookings",
                       image: Image.mountainBackground)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height * 0.15,
                           alignment: .center)
                Spacer()
            }
            
        }
    }
}
