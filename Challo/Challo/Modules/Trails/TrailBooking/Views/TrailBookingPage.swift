//
//  TrailBookingPage.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailBookingPage: View {

    @ObservedObject var presenter: TrailBookingPresenter
    @EnvironmentObject var trailProfilePresenter: TrailProfilePresenter

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        Image.guidesBackground
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * (1 / 4.0),
                                   alignment: .center)
                        TrailBookingOptions(presenter: presenter,
                                            width: geometry.size.width,
                                            height: geometry.size.height * (2 / 3.0))
                        TrailProfileDetails()
                            .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 50))
                    }
                    Spacer().frame(height: 100)
                }
            }
        }
        .onAppear {
            guard let trail = trailProfilePresenter.currentTrail else {
                return
            }
            presenter.populateTrailBookingPage(for: trail)
        }
    }
}
