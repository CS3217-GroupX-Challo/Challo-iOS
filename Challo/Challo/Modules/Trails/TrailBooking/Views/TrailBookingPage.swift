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

    var body: some View {
        PageLayout { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    if presenter.isLoading {
                        HStack {
                            Spacer()
                            Loading(isAnimating: .constant(true), style: .large)
                            Spacer()
                        }
                    } else {
                        TrailBookingOptions(presenter: presenter,
                                            width: geometry.size.width,
                                            height: geometry.size.height * (2 / 3.0))
                    }
                }
                Spacer().frame(height: 100)
            }.alert(isPresented: $presenter.isShowingAlert) {
                Alert(title: Text(presenter.alertTitle),
                      message: Text(presenter.alertMessage),
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
}
