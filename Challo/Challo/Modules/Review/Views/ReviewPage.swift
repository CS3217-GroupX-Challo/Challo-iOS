//
//  ReviewPage.swift
//  Challo
//
//  Created by Tan Le Yang on 11/4/21.
//

import SwiftUI

struct ReviewPage: View {

    @ObservedObject var presenter: ReviewPresenter

    var body: some View {
        GeometryReader { geometry in
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
                                comments: $presenter.comments)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
