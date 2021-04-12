//
//  ReviewPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

import SwiftUI

class ReviewPresenter: PresenterProtocol {

    var interactor: ReviewInteractor!
    var router: ReviewRouter?

    /// The booking to give a review for
    var booking: Booking

    init(booking: Booking) {
        self.booking = booking
    }

    @Published var comments: String = ""
    @Published var rating: Int = 0
}
