//
//  GuideDetailsPage.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//
import SwiftUI

struct GuideProfilePage: View {
    @ObservedObject var presenter: GuideProfilePresenter
    
    var guide: Guide {
        presenter.guide
    }
    
    var name: String {
        guide.name ?? "Guide"
    }
    
    var date: String {
        guide.dateJoined?.description ?? ""
    }
    
    var reviews: [Review] {
        presenter.reviews
    }
    
    var languages: String {
        (guide.languages ?? []).joined(separator: ",")
    }
    
    var divider: some View {
        Divider().padding(.vertical, 30)
    }
    
    func makeSectionTitle(_ label: String) -> some View {
        Text(label)
            .font(.title2)
            .bold()
            .padding(.bottom, 30)
    }
    
    let trailImageWidth: CGFloat = 200
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Hi, I'm \(name)")
                            .font(.title)
                        if let dateJoined = guide.dateJoined {
                            Text("Joined since \(CustomDateFormatter.displayFriendlyDate(dateJoined))")
                                .foregroundColor(Color(.systemGray2))
                        }
                        if presenter.isLoadingReviews {
                            Loading(isAnimating: .constant(true), style: .medium)
                        } else {
                            StarRatingsView(rating: guide.rating, numOfReviews: reviews.count)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    Spacer()
                    ImageLoader(profileImg: guide.profileImg,
                                width: 100,
                                height: 100,
                                defaultImage: "avatar-image")
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                }
                divider
                VStack(alignment: .leading, spacing: 20) {
                    makeSectionTitle("About")
                    Image(systemName: "text.quote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(.gray)
                    Text(guide.biography ?? "")
                    HStack(spacing: 10) {
                        Image(systemName: "message.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .foregroundColor(Color.themeTertiary)
                        Text("Speaks \(languages)")
                            .font(.caption)
                    }
                    if let accreditations = guide.accreditations {
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .foregroundColor(Color.themeTertiary)
                            VStack(alignment: .leading, spacing: 2) {
                                ForEach(accreditations, id: \.self) { accredit in
                                    Text(accredit)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
                divider
                VStack(alignment: .leading, spacing: 20) {
                    makeSectionTitle("Trails")
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(guide.trails, id: \.trailId) { trail in
                                VStack(alignment: .leading) {
                                    ImageLoader(profileImg: trail.images[0],
                                                width: trailImageWidth, height: trailImageWidth,
                                                defaultImage: "mountain-background")
                                        .frame(width: trailImageWidth, height: trailImageWidth)
                                        .cornerRadius(10)
                                    Text(trail.title)
                                    StarRatingsView(rating: trail.rating, maxHeight: 10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.frame(width: trailImageWidth + 30)
                            }
                        }
                    }
                }
                divider
                VStack(alignment: .leading, spacing: 20) {
                    if presenter.isLoadingReviews {
                        HStack {
                            Spacer()
                            Loading(isAnimating: .constant(true), style: .medium)
                            Spacer()
                        }
                    } else {
                        makeSectionTitle("\(reviews.count) reviews")
                        ScrollView(.horizontal) {
                            HStack(spacing: 0) {
                                ForEach(reviews, id: \.reviewId) { review in
                                    TrailProfileReview(review: review)
                                        .frame(width: 350, height: 250)
                                }
                            }.padding(EdgeInsets(top: 0, leading: 10, bottom: 20, trailing: 10))
                        }
                    }
                }
            }.padding(.horizontal, 80)
            .padding(.top, 50)
            .padding(.bottom, 80)
        }.onAppear {
            presenter.interactor.getReviews()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
