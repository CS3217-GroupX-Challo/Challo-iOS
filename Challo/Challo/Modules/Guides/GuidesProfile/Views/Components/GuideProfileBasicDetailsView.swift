//
//  GuideProfileBasicDetailsView.swift
//  Challo
//
//  Created by Shao Yi on 17/4/21.
//

import SwiftUI

struct GuideProfileBasicDetailsView: View {
    
    @EnvironmentObject var presenter: GuideProfilePresenter

    let name: String
    let dateJoined: Date?
    let profileImg: String?
    let rating: Double
    let reviews: [Review]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Hi, I'm \(name)")
                    .font(.title)
                if let dateJoined = dateJoined {
                    Text("Joined since \(CustomDateFormatter.displayFriendlyDate(dateJoined))")
                        .foregroundColor(Color(.systemGray2))
                }
                if presenter.isLoadingReviews {
                    Loading(isAnimating: .constant(true), style: .medium)
                } else {
                    StarRatingsView(rating: rating, numOfReviews: reviews.count)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            Spacer()
            ImageLoader(profileImg: profileImg,
                        width: 100,
                        height: 100,
                        defaultImage: "avatar-image")
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
        }
    }
}
