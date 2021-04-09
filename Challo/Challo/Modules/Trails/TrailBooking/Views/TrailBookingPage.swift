//
//  TrailBookingPage.swift
//  Challo
//
//  Created by Tan Le Yang on 28/3/21.
//

import SwiftUI

struct TrailBookingPage: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: TrailBookingPresenter
    @EnvironmentObject var trailProfilePresenter: TrailProfilePresenter
    let startDate = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2_020, month: 01, day: 01))!
    let endDate = Calendar(identifier: .gregorian).date(from: DateComponents(year: 2_021, month: 12, day: 31))!

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
                    }
                    Spacer().frame(height: 100)
                }
            }
        }
        .alert(isPresented: $presenter.isShowingBookingStatusAlert) {
            Alert(title: Text(presenter.bookingStatusTitle),
                  message: Text(presenter.bookingStatusMessage),
                  dismissButton: Alert.Button.default(
                    Text("Okay"), action: {
                        if self.presenter.isSuccessAlert {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                  ))
        }
        .onAppear {
            guard let trail = trailProfilePresenter.currentTrail else {
                return
            }
            presenter.populateTrailBookingPage(for: trail)
        }
    }
}
