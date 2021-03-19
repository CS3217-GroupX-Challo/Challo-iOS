//
//  GuideDetailsPage.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//
import SwiftUI

struct GuideProfilePage: View {
    @ObservedObject var presenter: GuideProfilePagePresenter
    
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
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.profileBackground
                        .resizable()
                    VStack {
                        HStack(spacing: 30) {
                            Image(guide.profileImg ?? "avatar-image")
                                .resizable()
                                .frame(width: geometry.size.width / 6,
                                       height: geometry.size.width / 6,
                                       alignment: .center)
                                .clipShape(Circle())
                                .offset(x: geometry.size.width / 20)
                            GuideProfileDetailsView(rating: (guide.rating as NSDecimalNumber).doubleValue,
                                                    name: name,
                                                    date: date,
                                                    languages: "")
                            .offset(x: geometry.size.width / 20)
                            Spacer()
                            // TODO add button later
                        }
                    }
                }
                .frame(height: geometry.size.height / 4,
                       alignment: .center)
                Spacer()
                TabView {
                    GuideAboutDetailsView(guide: guide,
                                          width: geometry.size.width,
                                          height: geometry.size.height)
                        .tabItem {
                            Image(systemName: "info.circle.fill")
                            Text("About")
                        }
                    GuideReviewsDetailsView(guide: guide,
                                            reviews: reviews,
                                            width: geometry.size.width)
                        .tabItem {
                            Image(systemName: "star.fill")
                            Text("Reviews")
                        }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
