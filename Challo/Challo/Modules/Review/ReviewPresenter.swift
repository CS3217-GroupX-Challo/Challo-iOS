//
//  ReviewPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

class ReviewPresenter: PresenterProtocol, AlertPresenter {

    var interactor: ReviewInteractor!
    var router: ReviewRouter?

    /// The booking to give a review for
    var booking: Booking

    init(booking: Booking) {
        self.booking = booking
    }

    @Published var comments: String = ""
    @Published var rating: Int = 0

    // MARK: Alert Presenter
    @Published var isSuccessAlert: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var alertTitle: String = ""
    @Published var alertMessage: String = ""

    var existingReview: Review? {
        booking.review
    }

    func submitReview() {
        let (success, message) = validateInputs()
        
        if !success {
            presentFailureAlert(title: "Failed to submit review", message: message)
            return
        }

        let newReview = NewReview(bookingId: booking.bookingId,
                                  trailId: booking.trail.trailId,
                                  guideId: booking.guide.userId,
                                  touristId: booking.tourist.userId,
                                  comments: comments,
                                  rating: rating)
        interactor.submitReview(review: newReview, onSubmission: { [weak self] success, _ in
            if !success {
                self?.presentFailureAlert(title: "Failed to submit review",
                                          message: "Oops, something went wrong, please try again!")
                return
            }
            
            self?.presentSuccessAlert(title: "Thank you for sharing your experience!",
                                      message: "You review has been submitted")
        })
    }
}

// MARK: Input Validation
extension ReviewPresenter {

    private func validateInputs() -> (success: Bool, message: String) {
        if comments.isEmpty {
            return (success: false, message: "Please leave a comment about your guide!")
        }
        
        if rating == 0 {
            return (success: false, message: "Please leave a rating from 1 - 5")
        }
        
        return (success: true, message: "")
    }
}
