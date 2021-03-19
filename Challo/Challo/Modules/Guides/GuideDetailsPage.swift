//
//  GuideDetailsPage.swift
//  Challo
//
//  Created by Kester Ng on 18/3/21.
//
import SwiftUI

struct GuideDetailsPage: View {
    var guide = Guide(userId: UUID(),
                      email: "test",
                      profileImg: nil,
                      name: "Bobby",
                      phone: "97121212",
                      dateJoined: Date(),
                      location: nil,
                      sex: Sex.Male,
                      daysAvailable: [],
                      trails: [],
                      unavailableDates: nil,
                      yearsOfExperience: 2,
                      languages: ["English", "Hindi"],
                      accreditations: nil,
                      biography: "The best guide in the world!\nWhat are we gonna do today?")
    
    var trail = Trail(trailId: UUID(), title: "Nandadevi Village", description: "Guided tours available from 1500 ₹",
                      positions: [], distance: Decimal.zero, duration: Decimal.zero,
                      elevation: Decimal.zero, images: [],
                      area: Area(areaId: UUID(), areaName: "test", regionName: "test"))
    
    var tourist = Tourist(userId: UUID(), email: "ss", profileImg: nil,
                          name: "Bobby", phone: "123", dateJoined: Date(), sex: Sex.Male)
    
    var name: String {
        guide.name ?? "Guide"
    }
    
    var date: String {
        guide.dateJoined?.description ?? ""
    }
    
    var review: Review {
        Review(reviewId: UUID(), rating: 3,
               comment: "Best guide ever! Please tell him I love him :)\nYays!",
               guide: guide, trail: trail,
               createdAt: Date(), tourist: tourist)
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
                                            review: review,
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
