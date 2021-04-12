//
//  ReviewPage.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct ReviewPage: View {

    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: ReviewPresenter

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    HStack {
                        Header(title: "Leave a Review",
                               subtitle: "",
                               image: Image.mountainBackground)
                            .frame(width: geometry.size.width,
                                   height: geometry.size.height * 0.15,
                                   alignment: .center)
                        Spacer()
                    }
                    BookingDetailsView(width: geometry.size.width * 0.80,
                                       height: geometry.size.height * 0.30,
                                       booking: presenter.booking)
                    GuideRatingView(rating: $presenter.rating,
                                    comments: $presenter.comments,
                                    guideName: presenter.booking.guide.name ?? "your guide")
                    Button(action: {
                        presenter.submitReview()
                    }, label: {
                        Text("Submit Review")
                    }).buttonStyle(BorderedButtonStyle(borderColor: .themeTertiary, foregroundColor: .themeForeground))
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $presenter.isShowingAlert) {
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
    }
}
