//
//  GuidesListingPage.swift
//  Challo
//
//  Created by Kester Ng on 17/3/21.
//

import SwiftUI

struct GuidesListingPage: View {
    @State private var stuff: String = ""
    var guide = Guide(userId: UUID(),
                      email: "bob@gmail.com",
                      profileImg: nil,
                      name: "Bobby Yeo Shit Dog",
                      phone: "1212121",
                      dateJoined: Date(),
                      sex: Sex.Male,
                      daysAvailable: [],
                      trails: [],
                      unavailableDates: nil,
                      yearsOfExperience: 20,
                      languages: ["English", "Chinese"],
                      accreditations: ["Diving", "Being useless"],
                      biography: "Welcome to Singapore")
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.guidesBackground
                        .resizable()
                    VStack {
                        HStack {
                            GuidesListingTitle(leading: geometry.size.width / 5)
                            Spacer()
                        }
                        RoundedTextField(placeholder: "Search here...",
                                         text: $stuff,
                                         isPasswordField: false)
                    }
                }
                .frame(width: geometry.size.width,
                       height: geometry.size.height / 5,
                       alignment: .center)
                GuidesFiltersView(width: geometry.size.width / 5)
                ScrollView(showsIndicators: false) {
                    HStack(spacing: geometry.size.width / 20) {
                        GuideDetailsCard(guide: guide, width: geometry.size.width / 2)
                        GuideDetailsCard(guide: guide, width: geometry.size.width / 2)
                    }
                    HStack(spacing: geometry.size.width / 20) {
                        GuideDetailsCard(guide: guide, width: geometry.size.width / 2)
                        GuideDetailsCard(guide: guide, width: geometry.size.width / 2)
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
