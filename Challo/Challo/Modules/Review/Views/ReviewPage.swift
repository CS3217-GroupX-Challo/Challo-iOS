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

    var reviewWritingComponent: some View {
        VStack {
            ExperienceRatingView(rating: $presenter.rating,
                                 comments: $presenter.comments)
            Button(action: {
                presenter.submitReview()
            }, label: {
                Text("Submit Review")
            }).buttonStyle(BorderedButtonStyle(borderColor: .themeTertiary, foregroundColor: .themeForeground))
        }
    }

    var body: some View {
        PageLayout(titleLabel: "Leave a Review") { geometry in
            ScrollView {
                VStack {
                    BookingDetailsView(width: geometry.size.width * 0.80,
                                       height: geometry.size.height * 0.30,
                                       booking: presenter.booking)
                    if let review = presenter.existingReview {
                        VStack(alignment: .leading) {
                            ExistingReviewView(review: review)
                        }.padding()
                    } else {
                        reviewWritingComponent
                    }
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
