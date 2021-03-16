//
//  GuidesListingPage.swift
//  Challo
//
//  Created by Kester Ng on 16/3/21.
//

import SwiftUI

struct GuidesListingPage: View {
    @State private var stuff: String = ""
    @State private var test: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    Image.guidesBackground
                        .resizable()
                    VStack {
                        HStack {
                            Text("Let us guide\nyour way")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .bold()
                                .lineLimit(nil)
                                .padding(.init(top: 0,
                                               leading: geometry.size.width / 5,
                                               bottom: 0,
                                               trailing: 0))
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
                HStack(alignment: .top) {
                    DropDownMenu(selectedOption: $test,
                                 menuItems: ["Option1", "Option2", "Option3"],
                                 menuTitle: "Location",
                                 width: geometry.size.width / 5)
                    DropDownMenu(selectedOption: $test,
                                 menuItems: ["Option1", "Option2", "Option3"],
                                 menuTitle: "Popularity",
                                 width: geometry.size.width / 5)
                    DropDownMenu(selectedOption: $test,
                                 menuItems: ["Option1", "Option2", "Option3"],
                                 menuTitle: "Language",
                                 width: geometry.size.width / 5)
                    DropDownMenu(selectedOption: $test,
                                 menuItems: ["Option1", "Option2", "Option3"],
                                 menuTitle: "Gender",
                                 width: geometry.size.width / 5)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
