//
//  GuideDetailsPage.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//
import SwiftUI

struct GuideProfilePage: View {
    @EnvironmentObject var presenter: GuideProfilePresenter
    
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
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                GuideProfileBasicDetailsView(name: name,
                                             dateJoined: guide.dateJoined,
                                             profileImg: guide.profileImg,
                                             rating: guide.rating,
                                             reviews: reviews)
                divider
                makeSectionTitle("About")
                GuideProfileAboutView(biography: guide.biography,
                                      languages: languages,
                                      accreditations: guide.accreditations)
                divider
                VStack(alignment: .leading, spacing: 20) {
                    makeSectionTitle("Trails")
                    GuideTrailsListing(trails: guide.trails)
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
                        GuideReviewsView(reviews: reviews)
                    }
                }
            }.padding([.horizontal, .bottom], 80)
            .padding(.top, 50)
        }.onAppear {
            presenter.interactor.getReviews()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
